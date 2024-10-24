import 'dart:async';

import 'package:walicare/components/user_bottom_sheet.dart';
import 'package:walicare/components/user_tile.dart';
import 'package:walicare/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YourAddedUsersPage extends StatefulWidget {
  const YourAddedUsersPage({super.key, required this.isPatient});
  final isPatient;
  @override
  State<YourAddedUsersPage> createState() => _YourAddedUsersPageState();
}

class _YourAddedUsersPageState extends State<YourAddedUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String search = '';
  late Stream<QuerySnapshot<Map<String, dynamic>>> userStream;
  bool isNameSearch = true;
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);

    userStream = _firestore
        .collection('Users')
        .where('addedUsers', arrayContains: _authService.getCurrentUser()!.uid)
        .orderBy('username')
        .snapshots();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      search = _searchController.text.toLowerCase();
    });
  }

  void toggleSearch() {
    setState(() {
      isNameSearch = !isNameSearch;
      _searchController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title:  Text('Your Added ${widget.isPatient ? 'Clinics' : 'Patients'}'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: TextField(
            decoration: InputDecoration(hintText: widget.isPatient? 'Search clinic name' : isNameSearch ? 'Search name (FIRST LAST)' : 'Search birthday (ex. 8/20/2024)'),
            controller: _searchController,
          ),
        ),
        if(!widget.isPatient) 
          Row(
            children: [
              const SizedBox(width:25),
              TextButton(
                onPressed: toggleSearch,
                child: Text(
                  isNameSearch ? 'Search by birthdate?' : 'Search by name?',
                  style: TextStyle(
                    color: Colors.orange.shade600,
                  ),
                ),
              ),
              const Spacer(),
            ],
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
            return Center(
                child: Text(widget.isPatient
                    ? 'You have no clinics added...'
                    : 'No patients have added you...'));
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
    String typeOfUserSearch = isNameSearch
        ? userData['username'].toString().toLowerCase()
        : userData['birthday'].toString().toLowerCase();
    if (typeOfUserSearch.contains(search)) {
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
