import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/login/signup.dart';
import 'package:to_do_app/providers/Provider_auth.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "j";

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<ProviderAuth>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FireBaseFunctions.signin(
                    emailController.text, passwordController.text,

                    onSuccess: (label) {
                      pro.inituser();
                     Navigator.pushNamedAndRemoveUntil(
                      context, Home.routename, (route) => false,
                      arguments: label);
                },
                    onError: (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("error"),
                      content: Text(error.toString()),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"))
                      ],
                    ),
                  );
                });
              },
              child: const Text('Login'),
            ),
          ],
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
