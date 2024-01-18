import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/sub_screens/add_new_address_screen.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/sub_screens/select_payment_method_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:http/http.dart' as http;

class ShippingAddressScreen extends StatefulWidget {
  static const String routeName = 'shipping_address';

  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  bool isResponseGenerating = false;
  List addressesList = [];
  Map<String, dynamic>? selectedAddress;

  Future<String> getAddressesFunc() async {
    print('Get Addresses function CALLED!!!');

    try {
      setState(() {
        isResponseGenerating = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.spTokenKey) ?? '';
      String customerEmail = prefs.getString(AppConstants.spEmailKey) ?? '';

      String apiUrl =
          '${ApiStrings.hostNameUrl}${ApiStrings.getAddressesUrl}?customerEmail=$customerEmail';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      var responseData = jsonDecode(response.body);

      if (responseData['status'] == 200) {
        addressesList = responseData['addresses'];
      }

      if (addressesList.isNotEmpty) {
        selectedAddress = addressesList.first;

        prefs.setString(
          AppConstants.spAddressKey,
          selectedAddress.toString(),
        );
      }

      // print(
      //     'getAddressFunc() -------------------------------> ${response.body}');

      setState(() {
        isResponseGenerating = false;
      });

      return 'Addresses fetched';
    } catch (e) {
      print('getAddressesFunc error: $e');

      setState(() {
        isResponseGenerating = false;
      });
      return 'Error occured';
    }
  }

  void selectAddress(Map<String, dynamic> address) async {
    setState(() {
      selectedAddress = address;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(AppConstants.spAddressKey, address.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('Shipping addresses screen!');

    getAddressesFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kGrey1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        title: const Text('Shipping_address'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: isResponseGenerating
          ? const Center(
              child: CustomCircularProgressBar(),
            )
          : SizedBox(
              child: ListView(
                children: [
                  SizedBox(
                    child: ListView.separated(
                      itemCount: addressesList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return AddressWidget(
                          address: addressesList[index],
                          isSelected: addressesList[index] == selectedAddress,
                          onSelect: () async {
                            selectAddress(addressesList[index]);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      label: 'Add New Address',
                      onPress: () {
                        Navigator.of(context)
                            .pushNamed(AddNewAddressScreen.routeName)
                            .whenComplete(() {
                          getAddressesFunc();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      label: 'Apply',
                      onPress: () {
                        Navigator.of(context)
                            .pushNamed(SelectPaymentMethodScreen.routeName);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  final Map<String, dynamic> address;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
            const CircleAvatar(
              radius: 26,
              backgroundColor: AppConstants.kGrey2,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppConstants.kPrimaryColor1,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${address['addressType']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${address['street']} ${address['city']}, ${address['state']},${address['postalCode']}',
                    maxLines: 2,
                    style: const TextStyle(color: AppConstants.kGrey3),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_outlined
                  : Icons.radio_button_unchecked_outlined,
              color: AppConstants.kPrimaryColor1,
            ),
          ],
        ),
      ),
    );
  }
}
