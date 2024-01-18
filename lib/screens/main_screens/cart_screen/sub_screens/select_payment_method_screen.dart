import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/sub_screens/enter_pin_for_order_confirmation_screen.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  static const String routeName = 'select_payment_method';

  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  List<Map<String, String>> paymentMethod = [
    {
      'image': AppConstants.googleIcon,
      'name': 'Google Pay',
    },
    {
      'image': AppConstants.appleIcon,
      'name': 'Apple Pay',
    },
    {
      'image': AppConstants.paypalIcon,
      'name': 'Pay Pal',
    },
    {
      'image': AppConstants.masterCardIcon,
      'name': 'Master class',
    },
    {
      'image': AppConstants.walletIcon,
      'name': 'Wallet',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select the payment method you want to use.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: paymentMethod.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return PaymentMethodWidget(
                    paymentMethod: paymentMethod[index],
                    isAvailabe: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            PaymentMethodWidget(
              paymentMethod: const {
                'image': AppConstants.codIcon,
                'name': 'Cash on cash',
              },
              isAvailabe: true,
            ),
            const Spacer(flex: 2),
            CustomButton(
              label: 'Continue',
              onPress: () {
                Navigator.of(context).pushNamed(
                    EnterYourPinForOrderConfirmationScreen.routeName);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  PaymentMethodWidget({
    super.key,
    required this.paymentMethod,
    this.isAvailabe,
  });

  final Map<String, String> paymentMethod;
  bool? isAvailabe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.6,
            blurRadius: 1,
            offset: Offset(0, 0.8),
          ),
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            paymentMethod['image']!,
            height: 40,
            color: !isAvailabe! ? AppConstants.kGrey3 : null,
          ),
          const SizedBox(width: 10),
          Text(
            paymentMethod['name']!,
            style: TextStyle(
              color: !isAvailabe!
                  ? AppConstants.kGrey3
                  : AppConstants.kPrimaryColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            !isAvailabe!
                ? Icons.radio_button_unchecked_outlined
                : Icons.radio_button_checked_outlined,
            color: !isAvailabe!
                ? AppConstants.kGrey3
                : AppConstants.kPrimaryColor1,
          ),
        ],
      ),
    );
  }
}
