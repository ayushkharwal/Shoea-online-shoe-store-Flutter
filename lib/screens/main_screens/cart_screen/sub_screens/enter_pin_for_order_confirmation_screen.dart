import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/utils/custom_num_pad.dart';

class EnterYourPinForOrderConfirmationScreen extends StatefulWidget {
  static const String routeName = 'enter_your_pin';

  const EnterYourPinForOrderConfirmationScreen({super.key});

  @override
  State<EnterYourPinForOrderConfirmationScreen> createState() =>
      _EnterYourPinForOrderConfirmationScreenState();
}

class _EnterYourPinForOrderConfirmationScreenState
    extends State<EnterYourPinForOrderConfirmationScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your PIN'),
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
                'Enter your pin to confirm order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Pinput(
                controller: otpController,
                length: 4,
                readOnly: true,
                showCursor: true,
                onChanged: (value) {
                  if (otpController.text.length == 4) {
                    orderPlacedDialogBox(context, screenHeight);
                  }
                },
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
                    if (otpController.text.isNotEmpty) {
                      String currentText = otpController.text;
                      String newText =
                          currentText.substring(0, currentText.length - 1);
                      otpController.text = newText;
                    }
                  },
                  updateOtpIndex: (digit) {},
                  onSubmit: () {},
                  controller: otpController,
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
                      AppConstants.orderPlacedIcon,
                      height: 150,
                    ),
                    const Spacer(),
                    const Text(
                      'Order Successful!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You have successfully placed order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'View Order',
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
