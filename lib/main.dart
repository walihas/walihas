
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walicare/firebase_options.dart';
import 'package:walicare/services/auth/auth_gate.dart';
import 'package:walicare/themes/dark_mode.dart';
import 'package:walicare/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  
  runApp(

    const MyApp(),
  );
  //Remove this method to stop OneSignal Debugging
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: const AuthGate());
  }
}
