import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:walicare/components/user_bottom_sheet.dart';
import 'package:walicare/components/user_tile.dart';

class FindYourClinicPage extends StatefulWidget {
  const FindYourClinicPage({super.key});

  @override
  State<FindYourClinicPage> createState() => _FindYourClinicPageState();
}

class _FindYourClinicPageState extends State<FindYourClinicPage> {
  final TextEditingController _searchController = TextEditingController();
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String search = '';
  String accountType = '';
  late StreamSubscription listener;
  late Stream<QuerySnapshot<Map<String, dynamic>>> userStream;

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);

    userStream = _firestore
        .collection('Users')
        .orderBy('username')
        .where('accountType', isEqualTo: 'clinic')
        .snapshots(includeMetadataChanges: true);

    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      search = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: TextField(
            decoration: const InputDecoration(hintText: 'Search...'),
            controller: _searchController,
          ),
        ),
        Expanded(child: _buildUserList()),
      ]),
     
    );
  }

  // Future<String> getCurrentAccountType() async {
  //   late String data;
  //   await _firestore
  //       .collection('Users')
  //       .doc(_authService.getCurrentUser()!.uid)
  //       .get()
  //       .then((doc) {
  //     if (doc.exists) {
  //       print('doc exists');
  //     } else {
  //       print('doc doesnt exist');
  //     }
  //     data = doc.data()!['accountType'];
  //   }, onError: (e) => print("Error getting document: $e"));
  //   return data;
  // }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, usersSnapshot) {
          if (usersSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (usersSnapshot.hasError) {
            return Center(child: Text(usersSnapshot.error.toString()));
          }
          if (!usersSnapshot.hasData || usersSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No registered clinics yet...'));
          }

          return ListView(
              children: usersSnapshot.data!.docs.map((doc) {
            return _buildUserListItem(
              doc.data(),
              context,
            );
          }).toList());
        });
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['username'].toString().toLowerCase().contains(search)) {
      return UserTile(
        username: userData['username'],
        email: userData['email'],
        imageUrl: userData['imageUrl'],
        isRead: true,
        birthday: userData['birthday'],
        onTap: () {
          final UserBottomSheet userBottomSheet = UserBottomSheet(
            receiverUsername: userData['username'],
            receiverEmail: userData['email'],
            receiverID: userData['uid'],
            receiverImageUrl: userData['imageUrl'],
            receiverAccountType: userData['accountType'],
          );
          userBottomSheet.showUserBottomSheet(context);
        },
      );
    } else {
      return Container();
    }
  }
}
