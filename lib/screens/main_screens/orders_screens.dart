import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/app_logo.dart';
import 'package:shoea_flutter/screens/main_screens/components/order_widget.dart';
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

      print('BC 1');

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      print('BC 2');

      // log('getMyOrdersFunc() response.body: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (responseData['status'] == 200) {
        ordersList = responseData['orders'];
        log('orderList -------------------------> ${jsonEncode(ordersList)}');
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
                                  itemCount: 6,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      // height: 190,
                                      width: double.maxFinite,
                                      margin:
                                          AppConstants.defaultHorizontalPadding,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '5 items orders',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'on 19-1-2024',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 80,
                                            // width: 100,
                                            child: ListView.separated(
                                              itemCount: 5,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 12),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  // height: 60,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        'https://res.cloudinary.com/dkydo92xp/image/upload/v1703919692/Jumpman%20MVP/kp2bmcotxas1p0k38hae.jpg',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Total Cost: \$1999',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          CustomButton(label: 'Track Order'),
                                        ],
                                      ),
                                    );

                                    // return OrderWidget(
                                    //   isActive: true,
                                    //   label: ordersList[index]['productName'] ??
                                    //       'Nike',
                                    //   productColor: 'red',
                                    //   productSize: '5',
                                    //   productImage:
                                    //       'https://res.cloudinary.com/dkydo92xp/image/upload/v1703930427/AJKO%201/behd9zyemnc3qmqwervw.jpg',
                                    //   retail: ordersList[index]['totalPrice']
                                    //       .toString(),
                                    //   quantity: '3',
                                    //   deleteFunc: () {},
                                    //   wholeProduct: {},
                                    //   status: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: AppConstants.kGrey1,
                                    //       borderRadius:
                                    //           BorderRadius.circular(6),
                                    //     ),
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: 3, horizontal: 6),
                                    //     child: const Text(
                                    //       'In Delivery',
                                    //       style: TextStyle(
                                    //         fontSize: 10,
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   mainButton: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(right: 20),
                                    //     child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       style: const ButtonStyle(
                                    //         backgroundColor:
                                    //             MaterialStatePropertyAll(
                                    //           AppConstants.kPrimaryColor1,
                                    //         ),
                                    //       ),
                                    //       child: const Text(
                                    //         'Track Order',
                                    //         style: TextStyle(
                                    //           color: AppConstants.kGrey1,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
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
                              // return OrderWidget(
                              //   isActive: true,
                              //   status: Container(
                              //     decoration: BoxDecoration(
                              //       color: AppConstants.kGrey1,
                              //       borderRadius: BorderRadius.circular(6),
                              //     ),
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 3, horizontal: 6),
                              //     child: const Text(
                              //       'Completed',
                              //       style: TextStyle(
                              //         fontSize: 10,
                              //       ),
                              //     ),
                              //   ),
                              //   mainButton: Padding(
                              //     padding: const EdgeInsets.only(right: 20),
                              //     child: ElevatedButton(
                              //       onPressed: () {},
                              //       style: const ButtonStyle(
                              //         backgroundColor: MaterialStatePropertyAll(
                              //           AppConstants.kPrimaryColor1,
                              //         ),
                              //       ),
                              //       child: const Text(
                              //         'Leave Review',
                              //         style: TextStyle(
                              //           color: AppConstants.kGrey1,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // );
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
