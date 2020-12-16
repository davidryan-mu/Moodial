import 'package:flutter/material.dart';
import 'package:Moodial/api_service/api.dart';

class LoginForm extends StatefulWidget {
  final Function callback;
  final bool isLoggedIn;

  LoginForm({this.callback, this.isLoggedIn});

  @override
  _LoginFormState createState() =>
      _LoginFormState(callback: this.callback, isLoggedIn: this.isLoggedIn);
}

class _LoginFormState extends State<LoginForm> {
  Function callback;
  bool isLoggedIn;

  _LoginFormState({this.callback, this.isLoggedIn});
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Username'),
            TextFormField(
              controller: usernameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            Text('Password'),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0,
              ),
              child: ElevatedButton(
                child: Text('Log In'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing data')));
                    ApiService.login(
                            usernameController.text, passwordController.text)
                        .then((user) {
                      if (user.loginStatus == 'User logged in') {
                        this.callback(true);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(user.loginStatus)));
                      }
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
