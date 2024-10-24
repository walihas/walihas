import 'package:walicare/pages/login_page.dart';
import 'package:walicare/pages/register_clinic_page.dart';
import 'package:walicare/pages/register_patient_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login

  bool _showLoginPage = true;

  bool _registerPatient = false; 

  bool _registerClinic = false; 


  void togglePage() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  void togglePatientRegister() {
    setState(() {
      _showLoginPage = !_showLoginPage;
      _registerPatient = !_registerPatient;
    });
  }

  void toggleClinicRegister() {
    setState(() {
      _showLoginPage = !_showLoginPage;
      _registerClinic = !_registerClinic;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(onPatientTap: togglePatientRegister, onClinicTap: toggleClinicRegister,);
    } else if (_registerPatient) {
      return RegisterPatientPage(onTap: togglePatientRegister,);
    } else {
      return RegisterClinicPage(onTap: toggleClinicRegister,);
    }
  }
}
