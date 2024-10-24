import 'package:walicare/models/message.dart';
import 'package:walicare/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentAccountType() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('Users').doc(_authService.getCurrentUser()!.uid).get();
    final data = snapshot.data() as Map<String, dynamic>;
    return data['accountType'];
  }

 Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() async* {
    // bool isPatientBool = isPatient;
    // final docRef = _firestore
    //     .collection('PatientUsers').doc(_auth.currentUser!.uid);
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     if (doc.exists) {
    //       print(doc.exists);
    //       isPatientBool = true;
    //     }
    //   },
    //   onError: (e) => isPatientBool = false,
    // );
    bool isPatient = false;
    if (await getCurrentAccountType() == 'patient') {
      isPatient = true;
    }
    String text = isPatient ? 'clinic' : 'patient';
    yield* FirebaseFirestore.instance.collection('Users').snapshots();
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timeStamp: timeStamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();

    String chatRoomID = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
    
    await _firestore
        .collection('Users')
        .doc(receiverID).set({
          'isRead' : {
            currentUserID: false
          }
        }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
