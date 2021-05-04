import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/screens/main_screen/home_tab/chart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  CameraController _controller;

  bool _toggled = false; // toggle button value
  List<SensorValue> _data = []; // array to store the values
  int _bpm = 0; // beats per minute
  int _fs = 30; // sampling frequency (fps)
  int _windowLen = 30 * 6; // window length to display - 6 seconds
  double _alpha = 0.3; // factor for the mean value
  Timer _timer;
  AnimationController _animationController;
  double _iconScale = 1;
  CameraImage _image; // store the last camera image
  double _avg; // store the average value during calculation
  DateTime _now; // store the now Datetime
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController
      ..addListener(() {
        setState(() {
          _iconScale = 1.0 + _animationController.value * 0.4;
        });
      });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _toggled = false;
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  Future<void> loadCameras() async {
    if (await Permission.camera.isDenied) {
      if (await Permission.camera.isDenied) {
        Navigator.pop(context);
      }
    }
    var _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    await _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    // await _controller.setFlashMode(FlashMode.torch);
    _controller.startImageStream((image) {
      _image = image;
    });
  }

  void _clearData() {
    // create array of 128 ~= 255/2
    _data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++)
      _data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 128));
  }

  void _toggle() {
    _clearData();
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController?.repeat(reverse: true);
      setState(() {
        _toggled = true;
      });
      // after is toggled
      _initTimer();
      _updateBPM();
    });
  }

  void _unToggle() {
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.value = 0.0;
    setState(() {
      _toggled = false;
    });
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller.initialize();
      await _controller.setFlashMode(FlashMode.torch);
      _controller.startImageStream((CameraImage image) {
        _image = image;
      });
    } catch (Exception) {
      debugPrint(Exception);
    }
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {
        if (_image != null) _scanImage(_image);
      } else {
        timer.cancel();
      }
    });
  }

  void _scanImage(CameraImage image) {
    _now = DateTime.now();
    _avg =
        image.planes.first.bytes.reduce((value, element) => (value + element)) /
            image.planes.first.bytes.length;

    //print(_avg);
    if (_data.length >= _windowLen) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(_now, _avg));
    });
  }

  void _updateBPM() async {
    // Bear in mind that the method used to calculate the BPM is very rudimentar
    // feel free to improve it :)

    // Since this function doesn't need to be so "exact" regarding the time it executes,
    // I only used the a Future.delay to repeat it from time to time.
    // Ofc you can also use a Timer object to time the callback of this function
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data); // create a copy of the current data array
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm += 60 *
                1000 /
                (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        print(_bpm);
        setState(() {
          this._bpm = ((1 - _alpha) * this._bpm + _alpha * _bpm).toInt();
        });
      }
      await Future.delayed(Duration(
          milliseconds:
              1000 * _windowLen ~/ _fs)); // wait for a new set of _data values
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: screenSize.height * 0.1, bottom: screenSize.height * 0.05),
            height: screenSize.height * 0.25,
            width: screenSize.height * 0.25,
            decoration: BoxDecoration(
                border: Border.all(width: 10, color: Color(0xFF84E0D4)),
                borderRadius: BorderRadius.circular(100)),
            child: Align(
              alignment: Alignment.center,
              child: _toggled
                  ? Transform.scale(
                      scale: _iconScale,
                      child: IconButton(
                        icon: Icon(
                            _toggled ? Icons.favorite : Icons.favorite_border),
                        color: Colors.red,
                        iconSize: 64,
                        onPressed: _unToggle,
                      ),
                    )
                  : TextButton(
                      onPressed: _toggle,
                      child: Text(
                        "START",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
            ),
          ),
          Text(
            "$_bpm BPM",
            style: Theme.of(context).textTheme.headline3,
          ),
          Divider(
            indent: screenSize.width * 0.2,
            endIndent: screenSize.width * 0.2,
            thickness: 3,
          ),
          SizedBox(
            height: screenSize.height * (_toggled ? 0.05 : 0.15),
          ),
          _toggled
              ? Container(
                  height: screenSize.height * 0.25,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      color: Colors.black),
                  child: Chart(_data),
                )
              : Text(
                  "Please your finger on back camera and flash to start measure",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }
}
