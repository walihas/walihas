import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:walicare/components/home_grid_item.dart';
import 'package:walicare/components/my_drawer.dart';
import 'package:walicare/pages/appointments_page.dart';
import 'package:walicare/pages/find_your_clinic_page.dart';
import 'package:walicare/pages/messages_page.dart';
import 'package:walicare/pages/your_added_users_page.dart';
import 'package:walicare/services/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription listener;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userStream;
  String accountType = '';
  
  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    listener = _firestore
        .collection('Users')
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      if (!event.metadata.hasPendingWrites) {
        for (var doc in event.docs) {
          if (!doc.metadata.hasPendingWrites &&
              doc.data()['uid'] == _authService.getCurrentUser()!.uid) {
            setState(() {
              accountType = doc.data()['accountType'];
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const MyDrawer(
        isHomePage: true,
      ),
      body: accountType == ''
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeGridItem(
                            text: accountType == 'patient' ? 'Your Clinics' : 'Your Patients',
                            iconData: Icons.house,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YourAddedUsersPage(
                                    isPatient: accountType == 'patient',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: HomeGridItem(
                            text: accountType == 'patient'
                                ? 'Message Your Clinic'
                                : 'Message Your Patient',
                            iconData: Icons.message_rounded,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessagesPage(
                                    isPatient: accountType == 'patient',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeGridItem(
                            text: 'Video Call',
                            iconData: Icons.video_call,
                            onPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title: Text('Feature Coming Soon.'),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: HomeGridItem(
                            text: 'Appointment Schedule',
                            iconData: Icons.calendar_month,
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AppointmentsPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (accountType == 'patient')
                    Expanded(
                      child: HomeGridItem(
                        text: 'Find Your Clinic',
                        iconData: Icons.medication,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FindYourClinicPage(),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
