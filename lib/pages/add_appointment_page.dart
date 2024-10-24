import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walicare/services/auth/auth_service.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  final bodyController = TextEditingController();
  String dateText = 'Choose Date';
  DateTime selectedDate = DateTime.now();
  void submit() async {
    if (dateText == 'Choose Date' || bodyController.text.trim().isEmpty) {
      print('hi');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Please fill out all information regarding your appointment.')));
    } else {
      await _firestore
          .collection('Users')
          .doc(_authService.getCurrentUser()!.uid)
          .set(
        {
          'appointments': {
            selectedDate.toString(): bodyController.text.trim(),
          },
        },
        SetOptions(merge: true),
      );
      Navigator.pop(context);
    }
  }

  void showPicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
          DateTime.now().year + 2,
        ),
      );
      TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 0),
          initialEntryMode: TimePickerEntryMode.input);

      if (date != null && time != null) {
        selectedDate =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);

        setState(() {
          dateText = DateFormat.yMd().add_jm().format(selectedDate).toString();
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Add Appointment'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: bodyController,
              autocorrect: true,
              decoration: const InputDecoration(
                labelText: ('Appointment Description'),
              ),
              maxLines: null,
              maxLength: 50,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: showPicker,
                  label: Text(dateText),
                  icon: const Icon(Icons.date_range),
                ),

                ElevatedButton(
                  onPressed: () {
                    submit();
                  },
                  
                  child: Text('Submit', style: TextStyle(color: Colors.orange.shade600)),
                ),
                const SizedBox(width:20)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
