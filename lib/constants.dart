import 'package:flutter/material.dart';

class AppConstants {
  // APP DESCRIPTION
  static const String appName = 'Shoea';
  static const String appNameWithLogo = 'hoea';

// IMAGE PATHS
  static const String logo = 'assets/logo.svg';
  static const String wavingHandEmoji = 'assets/wavinghandemoji.svg';
// Welcome Images
  static const String welcome1 = 'assets/images/welcome_shoes1.png';
  static const String welcome2 = 'assets/images/welcome_shoes2.png';
  static const String welcome3 = 'assets/images/welcome_shoes3.png';
  static const String welcome4 = 'assets/images/welcome_shoes4.png';
  static const String welcome5 = 'assets/images/welcome_shoes5.png';
  static const String welcome6 = 'assets/images/welcome_shoes6.png';
  static const String welcome7 = 'assets/images/welcome_shoes7.png';

// Socials icons path
  static const String fbIcon = 'assets/icons/fb.svg';
  static const String googleIcon = 'assets/icons/google.svg';
  static const String appleIcon = 'assets/icons/apple.svg';
  static const String paypalIcon = 'assets/icons/paypal.svg';
  static const String masterCardIcon = 'assets/icons/mastercard.svg';
  static const String walletIcon = 'assets/icons/wallet.svg';
  static const String codIcon = 'assets/icons/cod.svg';
  static const String orderPlacedIcon = 'assets/icons/orderplaced.svg';
  static const String pinGeneratedIcon = 'assets/icons/pingenerated.svg';

// COLORS
  static const Color kPrimaryColor1 = Colors.black;
  static const Color kGrey1 = Color(0xfff5f5f5);
  static const Color kGrey2 = Color(0xffe0e0e0);
  static const Color kGrey3 = Color(0xffbdbdbd);

  static const Duration kDuration = Duration(milliseconds: 300);
  static const defaultHorizontalPadding = EdgeInsets.symmetric(horizontal: 20);

// HIVE BOX KEYS
  static String appHiveBox = 'appHiveBox';

// HIVE BOX KEYS
  static String productHiveKey = 'productsKey';
  static String companiesHiveKey = 'companiesKey';
  static String favProductsHiveKey = 'favProductsKey';
  static String cartProductHiveKey = 'cartProductKey';

  // SHARED PREFERENCES KEYS
  static String spTokenKey = 'token';
  static String spEmailKey = 'spEmail';
  static String spAddressKey = 'spAddress';
  static String spTotalPrice = 'spTotalPrice';
}
