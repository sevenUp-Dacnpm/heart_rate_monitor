import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/models/access_data/access_data.dart';
import 'package:heart_rate_monitor/services/api_services/authentication_services/authentication_services.dart';
import 'package:heart_rate_monitor/utils/validator/validator.dart';
import 'package:heart_rate_monitor/widgets/icons/notify_dialog/notify_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogging = false;
  var _formKey = GlobalKey<FormState>();
  var _usernameTextEditingController = TextEditingController();
  var _passwordTextEditingController = TextEditingController();

  Future<void> onLogin() async {
    if (!_formKey.currentState.validate()) return;
    setState(() {
      _isLogging = true;
    });
    AccessData result =
        await AuthenticationServices.login(_usernameTextEditingController.text, _passwordTextEditingController.text);
    if (result != null) {
      AccessData().token = result.token;
      AccessData().user = result.user;
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) => NotifyDialog("Failed", "Username or password is incorrect!", "Try again"));
    }
    setState(() {
      _isLogging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
                  onEditingComplete: onLogin,
                ),
                SizedBox(
                  height: screenSize.height * 0.3,
                ),
                if (_isLogging) Center(child: CircularProgressIndicator()),
                if (_isLogging) SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: _isLogging ? null : onLogin, child: Text("Sign In"))),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You don't have an account? "),
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/register");
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
