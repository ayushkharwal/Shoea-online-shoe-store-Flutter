import 'package:flutter/material.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_in_screen.dart';
import 'package:shoea_flutter/utils/app_state.dart';

class WelcomeScreen2 extends StatefulWidget {
  WelcomeScreen2({super.key});

  static const String routeName = '/welcome2';

  @override
  State<WelcomeScreen2> createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> {
  int currentPage = 0;

  List<Map<String, String>> welcomeScreenData = [
    {
      'text': 'We provide high quality products for you',
      'image': welcome7,
    },
    {
      'text': 'Your satisfaction is our number one priority',
      'image': welcome2,
    },
    {
      'text': 'Let\'s fulfill your fashion needs with Shoea right now!',
      'image': welcome4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: welcomeScreenData.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        welcomeScreenData[currentPage]['image']!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: defaultHorizontalPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    welcomeScreenData[currentPage]['text']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      welcomeScreenData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  const Spacer(flex: 2),
                  CustomButton(
                    label: 'Continue',
                    onPress: () {
                      setState(() {
                        if (currentPage < welcomeScreenData.length - 1) {
                          currentPage = currentPage + 1;
                        } else {
                          AppStateManger.setAppState(1);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            SignInScreen.routeName,
                            (route) => false,
                          );
                        }
                      });
                    },
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: currentPage == index ? 30 : 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
