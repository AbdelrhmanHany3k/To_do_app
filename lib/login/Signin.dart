import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/login/signup.dart';
import 'package:to_do_app/providers/Provider_auth.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "j";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderAuth>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  final RegExp emailRegex =
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FireBaseFunctions.signin(
                      emailController.text,
                      passwordController.text,
                      onSuccess: (label) {
                        pro.inituser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.routename,
                              (route) => false,
                          arguments: label,
                        );
                      },
                      onError: (error) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text(error.toString()),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Signupscreen.routename);
        },
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            "Don't have an account? Sign Up",
            style: TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}