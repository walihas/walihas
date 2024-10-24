import 'package:flutter/material.dart';
import 'package:walicare/components/my_button.dart';
import 'package:walicare/components/my_textfield.dart';
import 'package:walicare/components/terms.dart';
import 'package:walicare/pages/forgot_your_pw_page.dart';
import 'package:walicare/services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onPatientTap, required this.onClinicTap});
  final void Function()? onPatientTap;
  final void Function()? onClinicTap;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  //login method
  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          emailController.text, pwController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Please enter a valid email and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                isDarkMode
                    ? 'lib/assets/WaliCare2.png'
                    : 'lib/assets/WaliCare1.png',
                scale: 1.25,
              ),
              //welcome back
              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              //email textfield
              MyTextfield(
                hintText: 'Email',
                isObscure: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),
              //pw textfield
              MyTextfield(
                hintText: 'Password',
                isObscure: true,
                controller: pwController,
              ),
              // login button
              const SizedBox(height: 25),
              MyButton(
                  text: 'Login',
                  onPressed: () {
                    login(context);
                  }),
              // register now
              const SizedBox(height: 25),
              const Text('Not a member?'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onPatientTap,
                    child: const Text(
                      ' Register as patient',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 60),
                  GestureDetector(
                    onTap: onClinicTap,
                    child: const Text(
                      ' Register as clinic',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('By logging in you agree to the following ',
                      style: TextStyle(fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      Terms().showTermsAndConditions(context);
                    },
                    child: const Text(
                      'terms and conditions',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotYourPwPage()));
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
