import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({required this.hintText, required this.isObscure, required this.controller, this.multipleLines = false, this.focusNode, super.key});
  final String hintText;
  final bool isObscure;
  final TextEditingController controller;
  final bool multipleLines;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        focusNode: focusNode,
        maxLines: multipleLines ? null : 1,
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
