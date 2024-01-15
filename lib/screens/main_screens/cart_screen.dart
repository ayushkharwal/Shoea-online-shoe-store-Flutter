import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartList = [];

  List orderItemsId = [];

  List filteredProducts = [];

  getCartItems() {
    Box box = Hive.box(AppConstants.appHiveBox);

    cartList = box.get(AppConstants.cartProductHiveKey) ?? [];

    log('cartList in CartScreen: $cartList');

    orderItemsId = cartList.map((item) => item.productId).toList();

    // Now, you have a list of productId values in productIdList
    log('orderItemsId: $orderItemsId');

    List allProducts = box.get(AppConstants.productHiveKey);

    log('allProducts: $allProducts');

    for (Map<String, dynamic> product in allProducts) {
      if (orderItemsId.contains(product['productId'])) {
        filteredProducts.add(product);
      }
    }

    // log('Filtered Products: ${jsonEncode(filteredProducts)}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppConstants.kGrey1,
        appBar: AppBar(
          surfaceTintColor: AppConstants.kGrey1,
          backgroundColor: AppConstants.kGrey1,
          centerTitle: false,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: AppLogo(),
          ),
          title: const Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomSheet: customBottomSheet(size.height),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              SizedBox(
                child: ListView.separated(
                  itemCount: cartList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return OrderWidget(
                      label: cartList[index].productName,
                      productColor: cartList[index].productColor,
                      productSize: cartList[index].productSize,
                      retail: cartList[index].productRetail,
                      quantity: cartList[index].quantity,
                      productImage: cartList[index].imageLink,
                      isActive: false,
                      mainButton: Container(
                        margin: const EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          color: AppConstants.kGrey1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(cartList[index].quantity),
                            const Padding(
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

  customBottomSheet(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.1,
      child: Container(
        decoration: const BoxDecoration(
          color: AppConstants.kGrey1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.kGrey2,
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
}
