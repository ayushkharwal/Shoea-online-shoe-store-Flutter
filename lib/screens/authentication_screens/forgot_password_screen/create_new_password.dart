import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  static const String routeName = '/create_new_password';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Password'),
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
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.83,
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/create_new_password.svg',
                    height: size.height * 0.33,
                  ),
                  const Spacer(),
                  const Text('Create your New Password'),
                  const Spacer(),
                  CustomTextField(
                    hintText: 'Enter new password',
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: kPrimaryColor1,
                    ),
                  ),
                  const Spacer(),
                  CustomTextField(
                    hintText: 'Enter new password',
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: kPrimaryColor1,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(label: 'Continue'),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
