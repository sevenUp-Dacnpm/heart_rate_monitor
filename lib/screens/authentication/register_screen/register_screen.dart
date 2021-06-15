import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/models/user/user.dart';
import 'package:heart_rate_monitor/services/api_services/authentication_services/authentication_services.dart';
import 'package:heart_rate_monitor/utils/validator/validator.dart';
import 'package:heart_rate_monitor/widgets/icons/notify_dialog/notify_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isRegistering = false;
  var _formKey = GlobalKey<FormState>();
  var _usernameTextEditingController = TextEditingController();
  var _passwordTextEditingController = TextEditingController();
  Future<void> onRegister() async {
    if (!_formKey.currentState.validate()) return;
    setState(() {
      _isRegistering = true;
    });

    User result = await AuthenticationServices.register(
      _usernameTextEditingController.text,
      _passwordTextEditingController.text,
    );

    if (result != null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/login");
      showDialog(context: context, builder: (context) => NotifyDialog("Success", "Registered successfully", "OK"));
    } else {
      showDialog(
          context: context, builder: (context) => NotifyDialog("Failed", "Username already exists", "Try again"));
    }
    setState(() {
      _isRegistering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _usernameTextEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Username"),
                  textInputAction: TextInputAction.next,
                  validator: Validator.validateUsername,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Password"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _passwordTextEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Password",
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: Validator.validatePassword,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Confirm password"),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Password",
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (confirmPassword) {
                    if (confirmPassword == _passwordTextEditingController.text)
                      return null;
                    else
                      return "Confirm password does not match!";
                  },
                  onEditingComplete: onRegister,
                ),
                SizedBox(
                  height: screenSize.height * 0.18,
                ),
                if (_isRegistering) Center(child: CircularProgressIndicator()),
                if (_isRegistering) SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _isRegistering ? null : onRegister, child: Text("Sign Up"))),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/login");
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
