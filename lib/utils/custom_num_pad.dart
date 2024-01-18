import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;
  final Function(int) updateOtpIndex;

  const NumPad({
    Key? key,
    this.buttonSize = 60,
    this.buttonColor = Colors.black,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
    required this.updateOtpIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // double screenWidth = constraints.maxWidth;
        // double screenHeight = constraints.maxHeight;
        // double buttonSpacing = (screenWidth - (buttonSize * 3)) / 4;

        return Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberButton(
                    number: 1,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 2,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 3,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberButton(
                    number: 4,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 5,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 6,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberButton(
                    number: 7,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 8,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  NumberButton(
                    number: 9,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70 / 2),
                        ),
                      ),
                      onPressed: () => delete(),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                  NumberButton(
                    number: 0,
                    size: buttonSize,
                    color: buttonColor,
                    controller: controller,
                    updateOtpIndex: updateOtpIndex,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60 / 2),
                        ),
                      ),
                      onPressed: () => onSubmit(),
                      child: Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;
  final Function(int) updateOtpIndex;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
    required this.updateOtpIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          if (controller.text.length < 4) {
            controller.text += number.toString();
            updateOtpIndex(number - 1);
          }
        },
        child: Center(
          child: Center(
            child: Text(
              number.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppConstants.kGrey2,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
