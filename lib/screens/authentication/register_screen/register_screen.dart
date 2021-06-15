import 'package:flutter/material.dart';
import 'package:heart_rate_monitor/utils/validator/validator.dart';

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
  void onRegister() {}
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
                      hintText: "Nhập username"),
                  textInputAction: TextInputAction.next,
                  validator: Validator.validateUsername,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Mật khẩu"),
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
                    hintText: "Nhập mật khẩu",
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: Validator.validatePassword,
                  onEditingComplete: onRegister,
                ),
                SizedBox(
                  height: screenSize.height * 0.3,
                ),
                if (_isRegistering) Center(child: CircularProgressIndicator()),
                if (_isRegistering) SizedBox(height: 10),
                Container(width: double.infinity, child: ElevatedButton(onPressed: onRegister, child: Text("Sign In"))),
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
