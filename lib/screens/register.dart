import 'package:flutter/material.dart';
import '../cookie_request.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  String username = "";
  String password = "";
  String passwordConfirmation = "";
  String _errorMessage = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Panic Button'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Create An Account",
                  style: TextStyle(fontSize: 30)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "username",
                    labelText: "username",
                    icon: Icon(Icons.people, color: Colors.blue),
                  ),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null) {
                      return "Tolong isi kolom username";
                    }
                    else if (value.isEmpty) {
                      return "Tolong isi kolom username";
                    }
                    return null;
                  }
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password",
                    labelText: "password",
                    icon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null) {
                      return "Tolong isi password";
                    }
                    else if (value.isEmpty) {
                      return "Tolong isi password";
                    }
                    return null;
                  }
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password confirmation",
                    labelText: "password confirmation",
                    icon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  controller: passwordConfirmationController,
                  validator: (value) {
                    if (value == null) {
                      return "Tolong isi password 2";
                    }
                    else if (value.isEmpty) {
                      return "Tolong isi password 2";
                    }
                    return null;
                  }
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Submit",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      username = usernameController.text;
                      password = passwordController.text;
                      passwordConfirmation = passwordConfirmationController.text;

                      // "https://covid19-panic-button.herokuapp.com/authentication/register/"
                      // "http://127.0.0.1:8000/authentication/authentication/register/"

                      final response = await request
                          .login("https://covid19-panic-button.herokuapp.com/authentication/register/", {
                        'username': username,
                        'password1': password,
                        'password2': passwordConfirmation
                      });

                      if (response["status"] == true) {
                        Navigator.of(context).pop();
                      }

                      setState(() {
                        _errorMessage = response["message"];
                      });
                    }
                  }
                ),
                SizedBox(height: 20),
                Text(_errorMessage),
              ]
            )
          )
        )
      )
    );
  }
}