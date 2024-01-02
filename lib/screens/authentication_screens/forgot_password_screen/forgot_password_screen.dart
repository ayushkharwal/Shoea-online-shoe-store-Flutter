import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: defaultHorizontalPadding,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/forgot_password_vector.svg',
              height: size.height * 0.33,
            ),
            const Text(
              'Select which contact details should we use to reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            ContactDetail(
              iconData: Icons.message_rounded,
              label1: 'via SMS:',
              label2: '+1 111*****999',
            ),
            const Spacer(),
            ContactDetail(
              iconData: Icons.message_rounded,
              label1: 'via Email',
              label2: 'ayu*******mail.com',
            ),
            const Spacer(flex: 2),
            CustomButton(label: 'Continue'),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  ContactDetail({
    super.key,
    required this.iconData,
    required this.label1,
    required this.label2,
  });

  IconData iconData;
  String label1;
  String label2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kGrey3),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.034,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: kGrey2,
              child: Icon(
                iconData,
                size: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label1),
                const SizedBox(height: 4),
                Text(
                  label2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
