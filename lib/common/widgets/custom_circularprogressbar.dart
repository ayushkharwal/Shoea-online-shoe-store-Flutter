import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2,
      color: AppConstants.kPrimaryColor1,
    );
  }
}
