import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:shoea_flutter/utils/custom_num_pad.dart';
import 'package:http/http.dart' as http;
import 'package:shoea_flutter/utils/helper_method.dart';

class CreateOrderPinScreen extends StatefulWidget {
  static const String routeName = 'create_order_pin';

  const CreateOrderPinScreen({super.key});

  @override
  State<CreateOrderPinScreen> createState() => _CreateOrderPinScreenState();
}

class _CreateOrderPinScreenState extends State<CreateOrderPinScreen> {
  TextEditingController pinController = TextEditingController();

  bool isResponseGenerating = false;

  Future<bool> generateCustomerPIN(
      BuildContext context, double screenHeight) async {
    try {
      isResponseGenerating = true;

      String apiUrl =
          '${ApiStrings.hostNameUrl}${ApiStrings.generateCustomerPinUrl}';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String customerEmail = prefs.getString(AppConstants.spEmailKey) ?? '';
      String token = prefs.getString(AppConstants.spTokenKey) ?? '';

      Map<String, String> bodyData = {
        'customerEmail': customerEmail,
        'pin': pinController.text,
      };

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(bodyData),
      );

      print('generateCustomerPIN() response.body: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (responseData['msg'] == 'PIN Added successfully!') {
        if (!context.mounted) return true;
        orderPlacedDialogBox(context, screenHeight);
      }

      isResponseGenerating = false;
      return true;
    } catch (e) {
      print('generateCustomerPIN() Error: $e');
      isResponseGenerating = false;

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your PIN'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create your order pin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This PIN will be used for confirming your orders',
                style: TextStyle(
                  color: AppConstants.kGrey3,
                ),
              ),
              const SizedBox(height: 15),
              Visibility(
                visible: isResponseGenerating,
                child: CustomCircularProgressBar(),
              ),
              const SizedBox(height: 15),
              Pinput(
                controller: pinController,
                length: 4,
                readOnly: true,
                showCursor: true,
                onChanged: (value) {},
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
                keyboardType: TextInputType.number,
                obscureText: true,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                defaultPinTheme: PinTheme(
                  textStyle: const TextStyle(fontSize: 24),
                  height: screenHeight * 0.09,
                  width: screenWidth * 0.18,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConstants.kGrey2, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: AppConstants.kGrey1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: constraints.maxWidth > 600
                    ? EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.2)
                    : const EdgeInsets.symmetric(horizontal: 6),
                child: NumPad(
                  delete: () {
                    if (pinController.text.isNotEmpty) {
                      String currentText = pinController.text;
                      String newText =
                          currentText.substring(0, currentText.length - 1);
                      pinController.text = newText;
                    }
                  },
                  updateOtpIndex: (digit) {},
                  onSubmit: () {
                    if (pinController.text.length == 4) {
                      generateCustomerPIN(context, screenHeight);
                    } else {
                      HelperMethod.showSnackbar(
                          context, const Text('Please enter a 4 digit pin!'));
                    }
                  },
                  controller: pinController,
                  iconColor: AppConstants.kGrey2,
                  buttonColor: AppConstants.kPrimaryColor1,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<dynamic> orderPlacedDialogBox(
      BuildContext context, double screenHeight) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            height: screenHeight * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      AppConstants.pinGeneratedIcon,
                      height: 150,
                    ),
                    const Spacer(),
                    const Text(
                      'Pin Generated Successfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You have successfully created the PIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Continue',
                      onPress: () {},
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
