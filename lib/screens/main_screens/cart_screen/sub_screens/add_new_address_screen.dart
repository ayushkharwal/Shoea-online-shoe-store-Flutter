import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:http/http.dart' as http;

class AddNewAddressScreen extends StatelessWidget {
  static const String routeName = 'add_new_address';

  AddNewAddressScreen({super.key});

  final TextEditingController addressTypeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<String> addAddressFunc() async {
    try {
      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.addAddressUrl}';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.spTokenKey) ?? '';
      String customerEmail = prefs.getString(AppConstants.spEmailKey) ?? '';

      var bodyData = {
        'addressType': addressTypeController.text,
        'street': streetController.text,
        'city': cityController.text,
        'state': stateController.text,
        'postalCode': postalCodeController.text,
        'country': countryController.text,
        'customerEmail': customerEmail,
      };

      print('addAddressFunc bodyData: $bodyData');

      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(bodyData),
      );

      print('addAddressFunc() response.body: ${response.body}');
    } catch (e) {
      print('addAddressFunc error: $e');
    }

    return 'Address Added';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Add New Address'),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - 90,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Address Type',
                    textEditingController: addressTypeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter address type';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Street',
                    textEditingController: streetController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter street';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'city',
                    textEditingController: cityController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter city';
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'State',
                    textEditingController: stateController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter state';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Postal Code',
                    textEditingController: postalCodeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your postal code';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Country',
                    textEditingController: countryController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter country';
                      }
                    },
                  ),

                  // const SizedBox(height: 20),
                  // CustomTextField(label: 'Latitude',),
                  // const SizedBox(height: 20),
                  // CustomTextField(label: 'longitude',),
                  const SizedBox(height: 40),
                  CustomButton(
                    label: 'Add Address',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        String addAddress = await addAddressFunc();

                        print('addressAddress: $addAddress');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
