import 'package:flutter/material.dart';

class HomeGridItem extends StatelessWidget {
  const HomeGridItem(
      {required this.text,
      required this.iconData,
      required this.onPress,
      super.key});

  final String text;
  final IconData iconData;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPress,
      splashColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade600,
              const Color.fromARGB(255, 249, 193, 125),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: Colors.white, size: 90), // Adjust size if needed
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
