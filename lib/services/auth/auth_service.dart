import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  //instance of Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in

  Future<UserCredential> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection('Users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          },
          SetOptions(
            merge: true,
          ));
      //save device token

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, String password,
      String username, File selectedImage, bool isPatient,
      {String birthday = 'null'}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredential.user!.uid}.jpg');

      await storageRef.putFile(selectedImage);
      final imageUrl = await storageRef.getDownloadURL();

      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
        'accountType': isPatient ? 'patient' : 'clinic',
        'imageUrl': imageUrl,
        'addedUsers': [],
        'isRead': {},
        'appointments': {},
        'birthday': birthday,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  void addUser(String addedUserUID) {
    _firestore.collection('Users').doc(getCurrentUser()!.uid).update({
      'addedUsers': FieldValue.arrayUnion([addedUserUID])
    });
    _firestore.collection('Users').doc(addedUserUID).update({
      'addedUsers': FieldValue.arrayUnion([getCurrentUser()!.uid])
    });
  }

  void removeUser(String addedUserUID) {
    _firestore.collection('Users').doc(getCurrentUser()!.uid).update({
      'addedUsers': FieldValue.arrayRemove([addedUserUID])
    });
    _firestore.collection('Users').doc(addedUserUID).update({
      'addedUsers': FieldValue.arrayRemove([getCurrentUser()!.uid])
    });
  }

  // sign out
  void signOut() {
    _auth.signOut();
  }

  // errors
}
