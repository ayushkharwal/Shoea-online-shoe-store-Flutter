import 'package:flutter/material.dart';

class HaveAnAccount extends StatelessWidget {
  HaveAnAccount({
    super.key,
    required this.label,
    required this.buttonLabel,
    this.onPress,
  });

  String label;
  String buttonLabel;
  Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            buttonLabel,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
