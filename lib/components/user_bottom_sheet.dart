import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walicare/components/user_page_container.dart';
import 'package:walicare/pages/chat_page.dart';

import 'package:walicare/services/auth/auth_service.dart';

class UserBottomSheet {
  UserBottomSheet(
      {required this.receiverUsername,
      required this.receiverEmail,
      required this.receiverID,
      required this.receiverImageUrl,
      required this.receiverAccountType});
  final String receiverUsername;
  final String receiverEmail;
  final String receiverID;
  final String receiverImageUrl;
  final String receiverAccountType;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String addOrRemoveMessage = 'Add Clinic';
  IconData addOrRemoveIconData = Icons.add_circle;
  final AuthService _authService = AuthService();
  showUserBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        if (receiverAccountType == 'clinic') {
          return StreamBuilder(
              stream: _firestore
                  .collection('Users')
                  .doc(_authService.getCurrentUser()!.uid)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List list = List.from(snapshot.data!.data()!['addedUsers']);
                print(list);
                bool isAdded = list.isNotEmpty && list.contains(receiverID);
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  if (isAdded) {
                    addOrRemoveMessage = 'Remove Clinic';
                    addOrRemoveIconData = Icons.remove_circle;
                  } else {
                    addOrRemoveMessage = 'Add Clinic';
                    addOrRemoveIconData = Icons.add_circle;
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.orange.shade600,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 130),
                      CircleAvatar(
                        radius: 100,
                        foregroundImage: Image.network(receiverImageUrl).image,
                      ),
                      Text(receiverUsername,
                          style: const TextStyle(fontSize: 30)),
                      Text(receiverEmail, style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserPageContainer(
                            iconData: addOrRemoveIconData,
                            receiverUsername: receiverUsername,
                            receiverID: receiverID,
                            receiverImageUrl: receiverImageUrl,
                            iconText: addOrRemoveMessage,
                            iconSize: 27,
                            onTap: () {
                              if (isAdded == false) {
                                _authService.addUser(receiverID);
                              } else {
                                _authService.removeUser(receiverID);
                              }
                              setState(() {
                                isAdded = !isAdded;
                              });
                            },
                            color:
                                isAdded ? Colors.red : Colors.orange.shade600,
                          ),
                          const SizedBox(height: 10),
                          if (isAdded) ...[
                            UserPageContainer(
                                iconData: CupertinoIcons.bubble_left_fill,
                                receiverUsername: receiverUsername,
                                receiverID: receiverID,
                                receiverImageUrl: receiverImageUrl,
                                iconText: 'Message',
                                iconSize: 27,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        receiverUsername: receiverUsername,
                                        receiverID: receiverID,
                                        receiverImageUrl: receiverImageUrl,
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.orange.shade600),
                            
                          ]
                        ],
                      ),
                      const SizedBox(height: 130),
                    ],
                  );
                });
              });
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange.shade600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 130),
              CircleAvatar(
                radius: 100,
                foregroundImage: Image.network(receiverImageUrl).image,
              ),
              Text(receiverUsername, style: const TextStyle(fontSize: 30)),
              Text(receiverEmail, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  UserPageContainer(
                      iconData: CupertinoIcons.bubble_left_fill,
                      receiverUsername: receiverUsername,
                      receiverID: receiverID,
                      receiverImageUrl: receiverImageUrl,
                      iconText: 'Message',
                      iconSize: 27,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverUsername: receiverUsername,
                              receiverID: receiverID,
                              receiverImageUrl: receiverImageUrl,
                            ),
                          ),
                        );
                      },
                      color: Colors.orange.shade600),

                  //     UserPageContainer(
                  //       iconData: CupertinoIcons.video_camera_solid,
                  //       receiverUsername: receiverUsername,
                  //       receiverID: receiverID,
                  //       receiverImageUrl: receiverImageUrl,
                  //       iconText: 'Video',
                  //       iconSize: 35,
                  //       onTap: () {
                  //         print('clicked');
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //       },
                  //       color: Colors.orange.shade600,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 130),
                ],
              )
            ],
          );
        }
      },
    );
  }
}
