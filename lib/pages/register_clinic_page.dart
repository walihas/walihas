import 'dart:io';


import 'package:flutter/material.dart';
import 'package:walicare/components/my_button.dart';
import 'package:walicare/components/my_textfield.dart';
import 'package:walicare/components/user_image_picker.dart';
import 'package:walicare/services/auth/auth_service.dart';

class RegisterClinicPage extends StatefulWidget {
  const RegisterClinicPage({required this.onTap, super.key});
  final void Function()? onTap;

  @override
  State<RegisterClinicPage> createState() => _RegisterClinicPageState();
}

class _RegisterClinicPageState extends State<RegisterClinicPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController pwController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  // register method
  File? _selectedImage;

  void register(BuildContext context) async {
    final auth = AuthService();
    
    if(_selectedImage == null) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            'Please submit a profile image',
          ),
        ),
      );
    } else if (pwController.text == confirmPwController.text) {
      try {
        await auth.signUpWithEmailPassword(emailController.text,
            pwController.text, usernameController.text, _selectedImage!, false);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              (e.toString().substring(11, 12).toUpperCase() +
                      e.toString().substring(12))
                  .replaceAll('-', ' '),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            'Passwords don\'t match',
          ),
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
              Image.asset(isDarkMode ? 'lib/assets/WaliCare2.png' :'lib/assets/WaliCare1.png', scale: 2, ),
              //welcome back
              Text(
                'Let\'s create a clinic account for you',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              //email textfield
              UserImagePicker(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),
              const SizedBox(height: 10),
              MyTextfield(
                hintText: 'Clinic Name',
                isObscure: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),
                
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
              //pw textfield
              const SizedBox(height: 10),
              MyTextfield(
                hintText: 'Confirm Password',
                isObscure: true,
                controller: confirmPwController,
              ),
              // login button
              const SizedBox(height: 25),
              MyButton(
                text: 'Register',
                onPressed: () {
                  register(context);
                },
              ),
              // register now
              const SizedBox(height: 25),
                
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      ' Login now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
