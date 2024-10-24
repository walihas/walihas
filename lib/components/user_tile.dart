import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  UserTile(
      {super.key,
      required this.imageUrl,
      required this.username,
      required this.email,
      required this.onTap,
      required this.isRead,
      required this.birthday});
  final String username;
  final String email;
  final String imageUrl;
  final bool isRead;
  final String birthday;

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    print(isRead);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: Image.network(imageUrl).image,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username),
                birthday != 'null'
                    ? Row(
                        children: [
                          Text('$email, ',
                              style: const TextStyle(fontSize: 12)),
                          Text(birthday, style: const TextStyle(fontSize: 12)),
                        ],
                      )
                    : Text(email, style: const TextStyle(fontSize: 12))
              ],
            ),
            if (!isRead) ...[
              const Spacer(),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.shade600,
                ),
              ),
              const SizedBox(width: 10),
            ]
          ],
        ),
      ),
    );
  }
}
