import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/fav_products_screen.dart';

class MainAppScreenAppBar extends StatefulWidget {
  const MainAppScreenAppBar({
    super.key,
  });

  @override
  State<MainAppScreenAppBar> createState() => _MainAppScreenAppBarState();
}

class _MainAppScreenAppBarState extends State<MainAppScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: AppConstants.kGrey2,
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
                fontSize: 16,
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
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(FavProductsScreen.routeName)
                .then((value) {
              setState(() {});
            });
          },
          icon: const Icon(
            Icons.favorite_outline_sharp,
            size: 30,
          ),
        ),
      ],
    );
  }
}
