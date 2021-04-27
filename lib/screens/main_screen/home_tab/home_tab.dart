import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
              child: Text(
                "START",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Text(
            "000 BPM",
            style: Theme.of(context).textTheme.headline3,
          ),
          Divider(
            indent: screenSize.width * 0.2,
            endIndent: screenSize.width * 0.2,
            thickness: 3,
          ),
          SizedBox(
            height: screenSize.height * 0.15,
          ),
          Text(
            "Please your finger on back camera and flash to start measure",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
