import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';
import 'package:shoea_flutter/screens/main_screens/orders_screen/sub_screens/view_order_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';
import 'package:http/http.dart' as http;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List ordersList = [];
  bool isResponseGenerating = false;

  Future<String> getMyOrdersFunc() async {
    try {
      setState(() {
        isResponseGenerating = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.spTokenKey) ?? '';
      String userEmail = prefs.getString(AppConstants.spEmailKey) ?? '';

      String apiUrl =
          '${ApiStrings.hostNameUrl}${ApiStrings.getMyOrdersUrl}?userEmail=$userEmail';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      // log('getMyOrdersFunc() response.body: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (responseData['status'] == 200) {
        ordersList = List.from(responseData['orders']).reversed.toList();

        // log('orderList -------------------------> ${jsonEncode(ordersList)}');
      }
      setState(() {
        isResponseGenerating = false;
      });
    } catch (e) {
      setState(() {
        isResponseGenerating = false;
      });
      print('geyMyOrdersFunc() ERROR: $e');
    }

    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyOrdersFunc();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: AppLogo(),
          ),
          title: const Text(
            'My Orders',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: AppConstants.kPrimaryColor1,
              indicatorColor: AppConstants.kPrimaryColor1,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    'Active',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  isResponseGenerating
                      ? const Center(
                          child: CustomCircularProgressBar(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: ordersList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          ViewOrderScreen.routeName,
                                          arguments: {
                                            'cartList': ordersList[index]
                                                ['cartList'],
                                            'orderDate': ordersList[index]
                                                ['orderDateTime'],
                                          },
                                        );
                                      },
                                      child: ViewOrderWidget(
                                        ordersList: ordersList,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewOrderWidget extends StatelessWidget {
  const ViewOrderWidget({
    super.key,
    required this.ordersList,
    required this.index,
  });

  final List ordersList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: AppConstants.defaultHorizontalPadding,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.2,
            offset: Offset(0, 0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ordersList[index]['cartList'].length} items orders',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'on ${ordersList[index]['orderDateTime']}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            // width: 100,
            child: ListView.separated(
              itemCount: ordersList[index]['cartList'].length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index2) {
                return Container(
                  // height: 60,
                  width: 70,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.kGrey1,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.2,
                        offset: Offset(0, 0.3),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        ordersList[index]['cartList'][index2]['imageLink'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Cost: \$${ordersList[index]['totalPrice']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          CustomButton(label: 'View Order'),
        ],
      ),
    );
  }
}
