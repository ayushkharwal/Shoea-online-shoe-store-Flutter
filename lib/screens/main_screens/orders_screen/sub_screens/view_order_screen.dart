import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';

class ViewOrderScreen extends StatefulWidget {
  static const String routeName = 'view_order';

  ViewOrderScreen({
    super.key,
    required this.cartList,
    required this.orderDate,
  });

  var cartList;
  final String orderDate;

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  void initState() {
    super.initState();

    log('cartList: ${widget.cartList}');

    log('orderDate: ${widget.orderDate}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Order'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.cartList.length} item(s)',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: ' were ordered on ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: widget.orderDate,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.cartList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return OrderWidget(
                  isActive: true,
                  mainButton: Container(),
                  label: widget.cartList[index]['productName'],
                  productColor: widget.cartList[index]['productColor'],
                  productSize: widget.cartList[index]['productSize'],
                  retail: widget.cartList[index]['productRetail'],
                  quantity: widget.cartList[index]['quantity'],
                  productImage: widget.cartList[index]['imageLink'],
                  retailerId: widget.cartList[index]['retailerName'],
                  isInViewOrder: true,
                  wholeProduct: {},
                  deleteFunc: () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
