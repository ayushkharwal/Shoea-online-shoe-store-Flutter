import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.onPress,
    required this.label,
    this.buttonColor,
    this.labelColor,
  });

  var onPress;
  String label;
  Color? buttonColor;
  Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(buttonColor ?? Colors.black),
        ),
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
