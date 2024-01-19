import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/profile_picture_widget.dart';
import 'package:shoea_flutter/screens/main_screens/main_app_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:shoea_flutter/utils/app_state.dart';

class FillYourProfileScreen extends StatefulWidget {
  const FillYourProfileScreen({super.key});
  static const String routeName = '/profileDetails';

  @override
  State<FillYourProfileScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<FillYourProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DateTime dob = DateTime.now();
  GlobalKey genderKey = GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool isResponseGenerating = false;
  var addProfileDetailsFunction;
  bool _keyboardVisible = false;

  bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
          .hasMatch(value ?? '');

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _showGenderMenu(BuildContext context) async {
    final RenderBox overlay =
        genderKey.currentContext!.findRenderObject() as RenderBox;

    Offset position =
        overlay.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;

    showMenu<String>(
      context: context,
      color: AppConstants.kGrey1,
      position: RelativeRect.fromLTRB(
        20, // left padding
        y + 55, // top position below the text field
        20, // right padding
        overlay.size.height, // bottom padding
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'Male',
          child: Text('Male'),
        ),
        const PopupMenuItem<String>(
          value: 'Female',
          child: Text('Female'),
        ),
        const PopupMenuItem<String>(
          value: 'Other',
          child: Text('Other'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          genderController.text = value;
        });
      }
    });
  }

  // Future<String> addProfileDetailsFunc() async {
  //   try {
  //     setState(() {
  //       isResponseGenerating = true;
  //     });

  //     String apiUrl = '${ApiStrings.hostNameUrl}${ ApiStrings.addAdminProfileDetails}';

  //     var bodyData = {
  //       'name': fullNameController.text,
  //       'dob': dobController.text,
  //       'gender': genderController.text,
  //       'email': emailController.text,
  //       'phoneNumber': phoneNumberController.text,
  //     };

  //     var response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(bodyData),
  //     );

  //     print(
  //         'addProfileDetailsFunc() response.body -------------------> ${response.body}');
  //     setState(() {
  //       isResponseGenerating = false;
  //     });

  //     var responseData = jsonDecode(response.body);

  //     return responseData['message'];
  //   } catch (e) {
  //     print('addProfileDetailsFunc() Error -------------------> $e');
  //     setState(() {
  //       isResponseGenerating = false;
  //     });

  //     return '$e';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fill your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: !_keyboardVisible
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Full Name',
                      textEditingController: fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      key: genderKey,
                      onTap: () {
                        _showGenderMenu(context);
                      },
                      child: IgnorePointer(
                        child: CustomTextField(
                          label: 'Gender',
                          textEditingController: genderController,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down_rounded,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your gender';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1920),
                          currentDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: AppConstants.kPrimaryColor1,
                                  onPrimary: AppConstants.kGrey3,
                                  surface: AppConstants.kGrey1,
                                  onSurface: AppConstants.kPrimaryColor1,
                                ),
                                dialogBackgroundColor: Colors.blue[900],
                              ),
                              child: child ?? const SizedBox.shrink(),
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            DateFormat formatter = DateFormat('dd-MM-yyyy');
                            String dateOfBirth = formatter.format(value);

                            setState(() {
                              dobController.text = dateOfBirth.toString();
                            });
                          }
                        });
                      },
                      child: IgnorePointer(
                        child: CustomTextField(
                          label: 'Date of Birth',
                          readOnly: true,
                          textEditingController: dobController,
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      textEditingController: emailController,
                      suffixIcon: const Icon(
                        Icons.mail_rounded,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!isValidEmail(value)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Phone Number',
                      textEditingController: phoneNumberController,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value!.length < 10) {
                          return 'Enter your 10 digits phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    isResponseGenerating
                        ? const CustomCircularProgressBar()
                        : CustomButton(
                            label: 'Continue',
                            onPress: () async {
                              setState(() {
                                addProfileDetailsFunction = '';
                              });
                              if (formKey.currentState!.validate()) {
                                // addProfileDetailsFunction =
                                //     await addProfileDetailsFunc();
                                if (addProfileDetailsFunction ==
                                    'Profile details added') {
                                  AppStateManger.setAppState(3);

                                  if (!context.mounted) return;
                                  Navigator.of(context).pushReplacementNamed(
                                      MainAppScreen.routeName);
                                }
                              }
                            },
                          ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
