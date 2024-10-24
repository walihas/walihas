import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walicare/components/my_textfield.dart';

class ForgotYourPwPage extends StatefulWidget {
  const ForgotYourPwPage({super.key});

  @override
  State<ForgotYourPwPage> createState() => _ForgotYourPwPageState();
}

class _ForgotYourPwPageState extends State<ForgotYourPwPage> {
  bool isSent = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  void sentResetEmail(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    setState(() {
      isSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Your Password'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isDarkMode
                ? 'lib/assets/WaliCare2.png'
                : 'lib/assets/WaliCare1.png',
            scale: 1.25,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Card(
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, bottom: 16),
                          child: Text(
                            isSent
                                ? "Email sent!"
                                : "What's your account email?",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    MyTextfield(
                      hintText: 'Account email',
                      isObscure: false,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        sentResetEmail(emailController.text);
                      },
                      child: Text(isSent ? "Resend?" : "Send"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
