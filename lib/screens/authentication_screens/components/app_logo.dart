import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      logo,
      height: 60,
    );
  }
}
