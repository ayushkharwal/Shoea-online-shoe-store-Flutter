import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/main_app_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SelectPaymentMethodScreen extends StatefulWidget {
  static const String routeName = 'select_payment_method';

  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  bool isResponseGenerating = false;
  String placeOrderFunction = '';

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

  Future<String> placeOrderFunc() async {
    try {
      setState(() {
        isResponseGenerating = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String userAddress = prefs.getString(AppConstants.spAddressKey) ?? '';

      String userEmail = prefs.getString(AppConstants.spEmailKey) ?? '';

      int totalPrice = prefs.getInt(AppConstants.spTotalPrice) ?? 0;

      DateTime now = DateTime.now();
      DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
      String orderDateTime = dateFormatter.format(now);

      String orderId = const Uuid().v1();

      Box box = Hive.box(AppConstants.appHiveBox);
      List cartList = box.get(AppConstants.cartProductHiveKey);

      Map<String, dynamic> bodyData = {
        'orderId': orderId,
        'orderDateTime': orderDateTime,
        'totalPrice': totalPrice,
        'userEmail': userEmail,
        'userAddress': userAddress,
        'cartList': cartList,
      };

      log('bodyData: ${jsonEncode(bodyData)}');

      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.placeOrderUrl}';

      String token = prefs.getString(AppConstants.spTokenKey) ?? '';

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(bodyData),
      );

      print('placeOrderFunc() response.body: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (responseData['msg'] == 'Order Placed Successfully!') {
        return responseData['msg'];
      }

      setState(() {
        isResponseGenerating = false;
      });
    } catch (e) {
      setState(() {
        isResponseGenerating = false;
      });
      print('placeOrderFunc() error: $e');
      return '$e';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              onPress: () async {
                placeOrderFunction = await placeOrderFunc();

                if (placeOrderFunction == 'Order Placed Successfully!') {
                  Box box = Hive.box(AppConstants.appHiveBox);

                  box.put(AppConstants.cartProductHiveKey, []);

                  if (!context.mounted) return;
                  orderPlacedDialogBox(context, size.height);
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> orderPlacedDialogBox(
    BuildContext context, double screenHeight) {
  return showDialog(
    context: context,
    barrierDismissible: false,
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
                    onPress: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        MainAppScreen.routeName,
                        (route) => false,
                        arguments: 2,
                      );
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                      label: 'Return to Home Screen',
                      buttonColor: AppConstants.kGrey2,
                      labelColor: Colors.black,
                      onPress: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            MainAppScreen.routeName, (route) => false);
                      }),
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
