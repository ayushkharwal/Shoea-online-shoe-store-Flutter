import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/cart_screen.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/home_screen.dart';
import 'package:shoea_flutter/screens/main_screens/orders_screen/orders_screens.dart';
import 'package:shoea_flutter/screens/main_screens/profile_screen.dart';

class MainAppScreen extends StatefulWidget {
  MainAppScreen({super.key, this.currentTabIndex});
  int? currentTabIndex = 0;

  static const String routeName = '/main_app';

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  List<Widget> tabsBody = const [
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    // WalletScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabsBody[widget.currentTabIndex ?? 0],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.kGrey1,
        selectedItemColor: AppConstants.kPrimaryColor1,
        unselectedItemColor: AppConstants.kGrey3,
        showUnselectedLabels: true,
        currentIndex: widget.currentTabIndex ?? 0,
        type: BottomNavigationBarType.fixed,
        onTap: (currentIndex) {
          setState(() {
            widget.currentTabIndex = currentIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_bag_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          // BottomNavigationBarItem(
          //   label: 'Wallet',
          //   icon: Icon(Icons.wallet),
          // ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
