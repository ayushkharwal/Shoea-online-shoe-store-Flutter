import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/fill_your_profile_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_in_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_up_screen.dart';
import 'package:shoea_flutter/screens/main_screens/main_app_screen.dart';
import 'package:shoea_flutter/screens/welcome_screens/welcome_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  appNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final int appState = prefs.getInt('app_state') ?? 0;
    print('APPSTATE -------------------------> $appState');

    if (appState == 0) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushNamed(WelcomeScreen1.routeName);
    } else if (appState == 1) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushNamed(SignInScreen.routeName);
    } else if (appState == 2) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushNamed(FillYourProfileScreen.routeName);
    } else if (appState == 3) {
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushNamed(MainAppScreen.routeName);
    } else {
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushNamed(SignUpScreen.routeName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        appNavigation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                // color: Colors.black,
                // padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  AppConstants.logo,
                  height: 60,
                  theme: const SvgTheme(
                    currentColor: Colors.grey,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            const Text(
              AppConstants.appNameWithLogo,
              style: TextStyle(fontSize: 44, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
