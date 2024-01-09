import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/add_to_cart_screen.dart';
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
  final Box myAppBox = Hive.box(appHiveBox);

  Future<bool> getSpecialOffersFunc() async {
    try {
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
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == '200') {
          specialOffersImagesList = responseData['specialOffers'];

          return true;
        }
      }

      // print(
      //     'getSpecialOffersFunc() response.body ---------------------------> ${response.body}');

      // print(
      //     'specialOffersImagesList ----------------------> $specialOffersImagesList');s

      return false;
    } catch (e) {
      print('getSpecialOffersFunc() error ----------------------------> $e');
      return false;
    }
  }

  Future<bool> getProductsFunc() async {
    try {
      String apiUrl = '$hostNameUrl$getProductsUrl';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == '200') {
          List productList = responseData['products'] as List;
          List companiesList = responseData['companies'] as List;

          myAppBox.put(productHiveKey, productList);
          myAppBox.put(companiesHiveKey, companiesList);

          return true;
        }
      }

      // log('getProductsFunc response ----------------------> ${response.body}');

      return false;
    } catch (e) {
      print('getProductsFunc() error -----------------------> $e');
      return false;
    }
  }

  List productsHiveList = [];
  List companiesList = [];

  @override
  void initState() {
    super.initState();

    if (myAppBox.isNotEmpty) {
      productsHiveList = myAppBox.get(productHiveKey);
      companiesList = myAppBox.get(companiesHiveKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Future.wait([getProductsFunc(), getSpecialOffersFunc()]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CustomCircularProgressBar(),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some error occured'),
                  );
                } else {
                  return SingleChildScrollView(
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
                            itemCount: companiesList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.all(18),
                                    child: SvgPicture.network(
                                      companiesList[index]['companyImagePath'],
                                    ),
                                  ),
                                  Text(
                                    companiesList[index]['companyName'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
                            itemCount: productsHiveList.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AddToCartScreen.routeName,
                                    arguments: productsHiveList[index],
                                  );
                                },
                                child: ProductGridTile(
                                  productName: productsHiveList[index]
                                      ['productName'],
                                  productRetail: productsHiveList[index]
                                      ['productRetail'],
                                  imagePath: productsHiveList[index]
                                      ['productImages'][0],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.productName,
    required this.productRetail,
    required this.imagePath,
  });

  final String productName;
  final String productRetail;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.2,
            offset: Offset(0, 0.3),
          ),
        ],
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
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline_rounded)),
                ),
              ],
            ),
            const Spacer(),
            Text(
              productName,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '\$$productRetail',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
