import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/sub_screens/add_new_address_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:http/http.dart' as http;

class ShippingAddressScreen extends StatefulWidget {
  static const String routeName = 'shipping_address';

  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  Future<String> getAddressesFunc() async {
    try {
      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.getAddressesUrl}';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.spTokenKey) ?? '';
      String customerEmail = prefs.getString(AppConstants.spEmailKey) ?? '';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      print(
          'getAddressFunc() -------------------------------> ${response.body}');

      return 'Addresses fetched';
    } catch (e) {
      print('getAddressesFunc error: $e');
      return 'Error occured';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
      body: SizedBox(
        child: ListView(
          children: [
            SizedBox(
              child: ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return const AddressWidget();
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
              child: CustomButton(label: 'Apply'),
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '61480 Sunbrook Park, PC 5679',
                style: TextStyle(color: AppConstants.kGrey3),
              ),
            ],
          ),
          Icon(
            Icons.radio_button_checked_outlined,
            color: AppConstants.kPrimaryColor1,
          ),
        ],
      ),
    );
  }
}
