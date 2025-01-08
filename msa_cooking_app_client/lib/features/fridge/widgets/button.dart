import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String contentText;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.contentText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.black,
      child: Text(contentText, style: const TextStyle(color: Colors.white)),
    );
  }
}
