import 'package:flutter/material.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

customBottomSheet(double screenHeight) {
  return SizedBox(
    height: screenHeight * 0.1,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$585.00',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: CustomButton(label: 'Checkout'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kGrey1,
        appBar: AppBar(
          surfaceTintColor: kGrey1,
          backgroundColor: kGrey1,
          centerTitle: false,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: AppLogo(),
          ),
          title: const Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                size: 34,
              ),
            ),
          ],
        ),
        bottomSheet: customBottomSheet(size.height),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              SizedBox(
                child: ListView.separated(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return OrderWidget(
                      isActive: false,
                      mainButton: Container(
                        margin: const EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          color: kGrey1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text('1'),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 20,
                              ),
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.13),
            ],
          ),
        ));
  }
}
