import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 80,
      backgroundColor: kGrey1,
      child: Icon(
        Icons.person_rounded,
        color: kGrey3,
        size: 120,
      ),
    );
  }
}
