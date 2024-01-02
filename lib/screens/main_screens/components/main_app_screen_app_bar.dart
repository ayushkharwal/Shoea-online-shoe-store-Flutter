import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class MainAppScreenAppBar extends StatelessWidget {
  const MainAppScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: kGrey2,
          child: Icon(
            Icons.person_outline_rounded,
            size: 34,
          ),
        ),
        const Spacer(),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning 👋🏻',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Ayush Kharwal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(flex: 4),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            size: 36,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_outline_sharp,
            size: 36,
          ),
        ),
      ],
    );
  }
}
