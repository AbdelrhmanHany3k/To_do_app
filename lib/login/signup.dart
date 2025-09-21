import 'package:flutter/material.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';

class Signupscreen extends StatelessWidget {
  static const String routename = "g";

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Signupscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Signup Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FireBaseFunctions.createaccountauth(
                    name: nameController.text,
                    number: phoneController.text,
                    emailController.text,
                    passwordController.text,
                    onSuccess: (email) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Success"),
                          content: Text("Account created for $email"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // close dialog
                                Navigator.pop(context); // back to login
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
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
                },
                child: const Text('SignUp'),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            "Already have an account? Login",
            style: TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}