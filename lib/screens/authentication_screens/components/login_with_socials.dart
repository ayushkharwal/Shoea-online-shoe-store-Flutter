import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/constants.dart';

class LoginWithSocials extends StatelessWidget {
  const LoginWithSocials({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialsIcon(iconPath: fbIcon),
        SocialsIcon(iconPath: googleIcon),
        SocialsIcon(iconPath: appleIcon),
      ],
    );
  }
}

class SocialsIcon extends StatelessWidget {
  SocialsIcon({
    super.key,
    required this.iconPath,
  });

  String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          height: 40,
        ),
      ),
    );
  }
}
