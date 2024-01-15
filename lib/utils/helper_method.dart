import 'package:flutter/material.dart';

class HelperMethod {
  static showSnackbar(BuildContext context, content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;

      case 'blue':
        return Colors.blue;

      case 'green':
        return Colors.green;

      case 'black':
        return Colors.black;

      case 'white':
        return Colors.white;

      case 'brown':
        return Colors.brown;

      case 'cyan':
        return Colors.cyan;

      case 'purple':
        return Colors.purple;

      default:
        return Colors.black;
    }
  }
}
