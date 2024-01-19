import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/main_screens/cart_screen/sub_screens/shipping_address_screen.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/add_to_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartList = [];
  List orderItemsId = [];
  List filteredProducts = [];

  int totalPrice = 0;

  calculateTotalPrice() async {
    totalPrice = 0;

    for (var item in cartList) {
      int quantity = int.parse(item.quantity);
      int productRetail = int.parse(item.productRetail);
      totalPrice += quantity * productRetail;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppConstants.spTotalPrice, totalPrice);
  }

  getCartItems() {
    Box box = Hive.box(AppConstants.appHiveBox);

    cartList = box.get(AppConstants.cartProductHiveKey) ?? [];

    orderItemsId = cartList.map((item) => item.productId).toList();

    List allProducts = box.get(AppConstants.productHiveKey);

    for (Map<dynamic, dynamic> product in allProducts) {
      if (orderItemsId.contains(product['productId'])) {
        filteredProducts.add(product);
      }
    }

    calculateTotalPrice();
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        setState(() {
          cartList.clear();
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartItems();

    log('cartList: ${jsonEncode(cartList)}');
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: PopupMenuButton<int>(
                onSelected: (item) => handleClick(item),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                      value: 0, child: Text('Clear Cart List')),
                  // PopupMenuItem<int>(value: 1, child: Text('Settings')),
                ],
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
                  itemCount: cartList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    int productQuantity = int.parse(cartList[index].quantity);

                    var wholeProduct = filteredProducts.firstWhere(
                      (product) =>
                          product['productId'] == cartList[index].productId,
                      orElse: () => Map<String, dynamic>(),
                    );

                    // log('wholeProduct: $wholeProduct');

                    return OrderWidget(
                      label: cartList[index].productName,
                      productColor: cartList[index].productColor,
                      productSize: cartList[index].productSize,
                      retail: (int.parse(cartList[index].productRetail) *
                              int.parse(cartList[index].quantity))
                          .toString(),
                      quantity: cartList[index].quantity,
                      productImage: cartList[index].imageLink,
                      wholeProduct: wholeProduct,
                      isActive: false,
                      deleteFunc: () {
                        setState(() {
                          cartList.removeAt(index);
                          calculateTotalPrice();
                        });
                      },
                      onTapFunc: () {
                        Navigator.pushNamed(
                          context,
                          AddToCartScreen.routeName,
                          arguments: wholeProduct,
                        );
                      },
                      mainButton: Container(
                        margin: const EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          color: AppConstants.kGrey1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 32,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(10),
                                color: AppConstants.kGrey2,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 6,
                                    bottom: 6,
                                  ),
                                  child: Text(
                                    cartList[index].quantity,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -5,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  setState(() {
                                    productQuantity = productQuantity + 1;
                                    cartList[index].quantity =
                                        productQuantity.toString();

                                    calculateTotalPrice();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_rounded,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -2,
                              left: -6,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (productQuantity > 1) {
                                    setState(() {
                                      productQuantity = productQuantity - 1;
                                      cartList[index].quantity =
                                          productQuantity.toString();

                                      calculateTotalPrice();
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.minimize_rounded,
                                  size: 18,
                                  color: Colors.black,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
                width: 200,
                child: CustomButton(
                  label: 'Checkout',
                  onPress: () {
                    Navigator.of(context)
                        .pushNamed(ShippingAddressScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
