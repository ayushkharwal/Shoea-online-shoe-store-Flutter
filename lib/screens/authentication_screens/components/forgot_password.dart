import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({
    super.key,
    this.onTap,
  });

  var onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Text(
        'Forgot the password?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
