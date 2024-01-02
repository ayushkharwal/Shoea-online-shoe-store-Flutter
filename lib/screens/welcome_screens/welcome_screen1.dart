import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/welcome_screens/welcome_screen2.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  static const String routeName = '/welcome1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(welcome1),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 10),
              Row(
                children: [
                  const Text(
                    'Welcome to ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  SvgPicture.asset(
                    wavingHandEmoji,
                    height: 50,
                  ),
                ],
              ),
              const Text(
                'Shoea',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'The best sneaker & shoes e-commerce app of the century for your fashion needs!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              CustomButton(
                label: 'Continue',
                onPress: () {
                  Navigator.of(context).pushNamed(WelcomeScreen2.routeName);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
