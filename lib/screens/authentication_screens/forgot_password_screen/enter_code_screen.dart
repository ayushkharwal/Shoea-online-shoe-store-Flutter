import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';

class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({super.key});

  static const String routeName = '/enter_code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Code has been sent to +1111****9990'),
              const SizedBox(height: 20),
              Pinput(),
              const SizedBox(height: 20),
              Text('Resend code in 44 sec'),
              const SizedBox(height: 50),
              CustomButton(label: 'Verify'),
            ],
          ),
        ),
      ),
    );
  }
}
