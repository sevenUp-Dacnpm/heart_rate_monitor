import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/utils/validator/validator.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var _formKey = GlobalKey<FormState>();
  var _fullNameTextEditingController = TextEditingController();
  var _currentSelectedValue = 'Male';
  var _dobTextEditingController = TextEditingController();
  var _weightTextEditingController = TextEditingController();
  var _heightTextEditingController = TextEditingController();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
    );
    if (picked != null)
      setState(() => _dobTextEditingController.text = picked.toString());
  }

  var genderTypes = ["Male", "Female", "Other"];

  Future<void> saveForm() async {
    if (!_formKey.currentState.validate()) return;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Full name"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _fullNameTextEditingController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  // validator: Validator.validateUsername,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Gender"),
                SizedBox(
                  height: 5,
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          // labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Please select expense',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: genderTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Day of Birth"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _dobTextEditingController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Icon(Icons.calendar_today_sharp),
                  ),
                  textInputAction: TextInputAction.next,
                  // validator: Validator.validateUsername,
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Weight(kg)"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _weightTextEditingController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validator.validateWeight,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Height(m)"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _heightTextEditingController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validator.validateHeight,
                ),
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: saveForm,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.black),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
