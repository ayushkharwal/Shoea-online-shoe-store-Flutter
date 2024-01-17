import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/custom_divider.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/forgot_password.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/have_account.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/login_with_socials.dart';
import 'package:shoea_flutter/screens/authentication_screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_up_screen.dart';
import 'package:shoea_flutter/screens/main_screens/main_app_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:shoea_flutter/utils/app_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isResponseGenerating = false;

  var signInFunction;

  Future<String> signInFunc() async {
    try {
      setState(() {
        isResponseGenerating = true;
      });

      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.signInUrl}';

      var bodyData = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      var responseData = jsonDecode(response.body);
      print('signInFunc() responseData ---------------------> $responseData');

      setState(() {
        isResponseGenerating = false;
      });

      if (responseData['message'] == 'Entered password is incorrect') {
        return 'Entered password is incorrect';
      }
      if (responseData['message'] == 'Login successful') {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConstants.spTokenKey, responseData['token']);
        prefs.setString(AppConstants.spEmailKey, emailController.text);
        return 'Login successful';
      }
      if (responseData['message'] == 'That email is not registered') {
        return 'That email is not registered';
      }
      if (responseData['message'] == 'Entered password is incorrect') {
        return 'Entered password is incorrect';
      } else {
        return 'Some error occurred';
      }
    } catch (e) {
      print('signInFunc() Error--------------------------> $e');
      setState(() {
        isResponseGenerating = false;
      });
      return 'Some error occurred :(';
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: AppConstants.defaultHorizontalPadding,
              child: SizedBox(
                height: size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 4),
                    const AppLogo(),
                    const Spacer(),
                    const Text(
                      'Login to your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      textEditingController: emailController,
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
                    if (signInFunction == 'That email is not registered')
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            signInFunction,
                            style: TextStyle(
                                color: Colors.red.shade900, fontSize: 12),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Password',
                      textEditingController: passwordController,
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
                    const SizedBox(height: 10),
                    if (signInFunction == 'Entered password is incorrect')
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 2.1,
                          child: Text(
                            signInFunction,
                            style: TextStyle(
                                color: Colors.red.shade900, fontSize: 12),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    isResponseGenerating
                        ? const CustomCircularProgressBar()
                        : CustomButton(
                            label: 'Sign in',
                            onPress: () async {
                              setState(() {
                                signInFunction = '';
                              });
                              if (_formKey.currentState!.validate()) {
                                signInFunction = await signInFunc();
                              }
                              if (signInFunction == 'Login successful') {
                                AppStateManger.setAppState(3);

                                if (!context.mounted) return;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  MainAppScreen.routeName,
                                  (route) => false,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ForgotPassword(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                      ),
                    ),
                    const Spacer(flex: 2),
                    CustomDivider(label: 'or continue with'),
                    const Spacer(),
                    const LoginWithSocials(),
                    const Spacer(),
                    HaveAnAccount(
                      label: 'Don\'t have an account? ',
                      buttonLabel: 'Sign up',
                      onPress: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
