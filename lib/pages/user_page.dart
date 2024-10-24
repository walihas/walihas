import 'package:walicare/pages/chat_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.receiverUsername,
    required this.receiverEmail,
    required this.receiverID,
    required this.receiverImageUrl,
  });
  final String receiverUsername;
  final String receiverEmail;
  final String receiverID;
  final String receiverImageUrl;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            foregroundImage: Image.network(widget.receiverImageUrl).image,
          ),
          Text(widget.receiverUsername, style: const TextStyle(fontSize: 30)),
          Text(widget.receiverEmail, style: const TextStyle(fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  receiverUsername: widget.receiverUsername,
                                  receiverID: widget.receiverID,
                                  receiverImageUrl: widget.receiverImageUrl,
                                )));
                  },
                  icon: const Icon(Icons.messenger, size: 40)),
              const SizedBox(width: 25),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.video_call, size: 40))
            ],
          ),
        ],
      ),
    );
  }
}
