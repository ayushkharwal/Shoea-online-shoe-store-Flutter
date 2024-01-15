import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/custom_divider.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/have_account.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/login_with_socials.dart';
import 'package:shoea_flutter/screens/authentication_screens/fill_your_profile_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_in_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:http/http.dart' as http;
import 'package:shoea_flutter/utils/app_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isResponseGenerating = false;
  var signUpFunction;

  Future<String> signUpFunc() async {
    try {
      setState(() {
        isResponseGenerating = true;
      });

      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.signUpUrl}';

      var bodyData = {
        'email': emailController.text,
        'password': passwordController.text,
        'type': 'customer',
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      print('signUpFunc() response.body -----------------> ${response.body}');

      var responseData = jsonDecode(response.body);

      if (responseData['message'] == 'Signup successful') {
        print(
            'signUpFunc() status code -----------------> ${response.statusCode}');
        print(
            'signUpFunc() response body -----------------> ${response.body.toString()}');

        setState(() {
          isResponseGenerating = false;
        });
        return 'Signup successful';
      } else if (responseData['message'] ==
          'That email is already registered') {
        setState(() {
          isResponseGenerating = false;
        });
        return 'That email is already registered';
      } else {
        setState(() {
          isResponseGenerating = false;
        });
        return 'false 1';
      }
    } catch (e) {
      print('signupFunc() error -------------------> $e');
      setState(() {
        isResponseGenerating = false;
      });
      return 'false 2';
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print('signUpFunction ----------------------> $signUpFunction');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: AppConstants.defaultHorizontalPadding,
              child: SizedBox(
                height: size.height * 0.83,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    const AppLogo(),
                    const Spacer(),
                    const Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    CustomTextField(
                      textEditingController: emailController,
                      label: 'Email',
                      prefixIcon: const Icon(
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
                    const SizedBox(height: 10),
                    if (signUpFunction == 'That email is already registered')
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            signUpFunction,
                            style: TextStyle(
                                color: Colors.red.shade900, fontSize: 12),
                          ),
                        ),
                      ),
                    const Spacer(),
                    CustomTextField(
                      textEditingController: passwordController,
                      label: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_rounded,
                      ),
                      suffixIcon: const Icon(
                        Icons.visibility_off_rounded,
                        color: AppConstants.kGrey3,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter your 6 digits password';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    isResponseGenerating
                        ? const CustomCircularProgressBar()
                        : CustomButton(
                            label: 'Sign up',
                            onPress: () async {
                              setState(() {
                                signUpFunction = '';
                              });
                              if (_formKey.currentState!.validate()) {
                                signUpFunction = await signUpFunc();
                                if (signUpFunction == 'Signup successful') {
                                  AppStateManger.setAppState(2);

                                  if (mounted) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      FillYourProfileScreen.routeName,
                                      (route) => false,
                                    );
                                  }
                                }
                              }
                            },
                          ),
                    const Spacer(),
                    CustomDivider(label: 'or continue with'),
                    const Spacer(),
                    const LoginWithSocials(),
                    const Spacer(),
                    HaveAnAccount(
                      label: 'Already have an account?',
                      buttonLabel: 'Sign in',
                      onPress: () {
                        Navigator.of(context).pushNamed(SignInScreen.routeName);
                      },
                    ),
                    const Spacer(flex: 3),
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
