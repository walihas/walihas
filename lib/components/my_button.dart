import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text, required this.onPressed, super.key});
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 8,
        
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          
          decoration: BoxDecoration(
            
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
