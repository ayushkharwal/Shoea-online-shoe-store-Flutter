import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/components/main_app_screen_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/see_all_offers_screen.dart';
import 'package:shoea_flutter/utils/api_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List specialOffersImagesList = [];

  bool isSpecialOffersResponseGenerating = false;

  getSpecialOffersFunc() async {
    try {
      setState(() {
        isSpecialOffersResponseGenerating = true;
      });

      String apiUrl = '$hostNameUrl$getSpecialOffersUrl';

      var prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['status'] == '200') {
          specialOffersImagesList = responseData['specialOffers'];

          print('imagesAdded: $specialOffersImagesList');
        }
      }

      print(
          'getSpecialOffersFunc() response.body ---------------------------> ${response.body}');

      setState(() {
        isSpecialOffersResponseGenerating = false;
      });
    } catch (e) {
      setState(() {
        isSpecialOffersResponseGenerating = false;
      });
      print('getSpecialOffersFunc() error ----------------------------> $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSpecialOffersFunc();
  }

  @override
  Widget build(BuildContext context) {
    print('specialOffersImagesList: $specialOffersImagesList');

    return Scaffold(
      body: SafeArea(
        child: isSpecialOffersResponseGenerating
            ? const Center(
                child: CustomCircularProgressBar(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: defaultHorizontalPadding,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const MainAppScreenAppBar(),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.tune),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            'Special Offers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                SeeAllOffersScreen.routeName,
                                arguments: specialOffersImagesList,
                              );
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 160,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: kGrey1,
                          borderRadius: BorderRadius.circular(30),
                          image: specialOffersImagesList.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                    specialOffersImagesList[0]['image'],
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/sale_banners/sale_banner_1.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2 / 2.7,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const Text(
                                'Nike',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Most Popular',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 2 / 2.7,
                        ),
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons
                                                .favorite_outline_rounded)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'Nike Wooden Style',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '\$115.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
