import 'package:flutter/material.dart';

class UserPageContainer extends StatelessWidget {
  const UserPageContainer({
    super.key,
    required this.iconData,
    required this.receiverUsername,
    required this.receiverID,
    required this.receiverImageUrl,
    required this.iconText,
    required this.iconSize,
    required this.onTap,
    required this.color,
  });
  final Color color;
  final IconData iconData;
  final double iconSize;
  final String iconText;
  final String receiverUsername;
  final String receiverID;
  final String receiverImageUrl;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Column(
          mainAxisAlignment: iconText == 'Message' || iconText == 'Add Clinic' || iconText == 'Remove Clinic'
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconText == 'Message' || iconText == 'Add Clinic' || iconText == 'Remove Clinic')
              const SizedBox(height: 7),
            Icon(
              iconData,
              size: iconSize,
              color: color,
            ),
            if (iconText == 'Message') const SizedBox(height: 2),
            Text(
              iconText,
              style: TextStyle(
                color: color,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
