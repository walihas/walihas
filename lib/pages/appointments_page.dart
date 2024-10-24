import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walicare/pages/add_appointment_page.dart';
import 'package:walicare/services/auth/auth_service.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> appStream;
  late String deletedAppointmentDate = '';
  late String deletedAppointmentBody = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appStream = _firestore
        .collection('Users')
        .doc(_authService.getCurrentUser()!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.undo,
                    size: 30, color: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  if (deletedAppointmentDate == '') {
                    return;
                  }
                  _firestore
                      .collection('Users')
                      .doc(_authService.getCurrentUser()!.uid)
                      .set(
                    {
                      'appointments': {
                        deletedAppointmentDate: deletedAppointmentBody
                      },
                    },
                    SetOptions(merge: true),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.add,
                    size: 30, color: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAppointmentPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: appStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (!snapshot.hasData || snapshot.data!['appointments'].isEmpty) {
              return const Center(child: Text('No appointments added yet...'));
            }
            Map<String, dynamic> appointments = snapshot.data!['appointments'];

            var sortedByKeyAppointments = Map.fromEntries(
                appointments.entries.toList()
                  ..sort((e1, e2) => e1.key.compareTo(e2.key)));
            var dateList = sortedByKeyAppointments.keys.toList();
            var bodyList = sortedByKeyAppointments.values.toList();
            return Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ListView.builder(
                  itemCount: sortedByKeyAppointments.length,
                  itemBuilder: (context, index) {
                    return appointmentTile(dateList[index], bodyList[index]);
                  }),
            );
          },
        ));
  }

  Widget appointmentTile(String date, String body) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.medical_information),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd()
                      .add_jm()
                      .format(DateTime.parse(date))
                      .toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 2), // Reduce vertical space between lines
                Text(
                  body,
                  style: const TextStyle(
                      fontSize: 14), // Smaller text for better fit
                  softWrap: true,
                  overflow:
                      TextOverflow.clip, // Prevent unnecessary line breaks
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _firestore
                  .collection('Users')
                  .doc(_authService.getCurrentUser()!.uid)
                  .get()
                  .then((value) {
                deletedAppointmentBody = value.data()!['appointments'][date];
                deletedAppointmentDate = date;
              });
              _firestore
                  .collection('Users')
                  .doc(_authService.getCurrentUser()!.uid)
                  .set({
                'appointments': {
                  date: FieldValue.delete(),
                },
              }, SetOptions(merge: true));
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
