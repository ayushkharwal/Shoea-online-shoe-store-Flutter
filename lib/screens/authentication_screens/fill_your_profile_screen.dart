import 'package:flutter/material.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/profile_picture_widget.dart';

class FillYourProfileScreen extends StatelessWidget {
  const FillYourProfileScreen({super.key});

  static const String routeName = '/fill_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fill your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Stack(
                children: [
                  const ProfilePicture(),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomTextField(hintText: 'Full Name'),
              const Spacer(),
              CustomTextField(
                hintText: 'Date of Birth',
                suffixIcon: const Icon(
                  Icons.calendar_month_rounded,
                  color: kGrey3,
                ),
              ),
              const Spacer(),
              CustomTextField(
                hintText: 'Email',
                suffixIcon: const Icon(
                  Icons.mail_rounded,
                  color: kGrey3,
                ),
              ),
              const Spacer(),
              CustomTextField(
                hintText: 'Phone Number',
              ),
              const Spacer(),
              CustomTextField(
                hintText: 'Gender',
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: kGrey3,
                ),
              ),
              const Spacer(flex: 2),
              CustomButton(label: 'Continue'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
