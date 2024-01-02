import 'package:flutter/material.dart';
import 'package:shoea_flutter/screens/authentication_screens/forgot_password_screen/create_new_password.dart';
import 'package:shoea_flutter/screens/authentication_screens/forgot_password_screen/enter_code_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_in_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_up_screen.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/see_all_offers_screen.dart';
import 'package:shoea_flutter/screens/main_screens/main_app_screen.dart';
import 'package:shoea_flutter/screens/splash_screen.dart';
import 'package:shoea_flutter/screens/welcome_screens/welcome_screen1.dart';
import 'package:shoea_flutter/screens/welcome_screens/welcome_screen2.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case WelcomeScreen1.routeName:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen1());

      case WelcomeScreen2.routeName:
        return MaterialPageRoute(builder: (context) => WelcomeScreen2());

      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignInScreen());

      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());

      case EnterCodeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const EnterCodeScreen());

      case CreateNewPassword.routeName:
        return MaterialPageRoute(
            builder: (context) => const CreateNewPassword());

      case MainAppScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MainAppScreen());

      case SeeAllOffersScreen.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                SeeAllOffersScreen(specialOffersImagesList: arg as List));

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}