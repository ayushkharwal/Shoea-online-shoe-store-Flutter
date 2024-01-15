import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoea_flutter/common/widgets/custom_circularprogressbar.dart';
import 'package:shoea_flutter/common/widgets/custom_textfield.dart';
import 'package:shoea_flutter/common/widgets/product_grid_tile.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/add_to_cart_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/fav_products_screen.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/notification_screen.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/products_by_category_screen.dart';
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
  final Box myAppBox = Hive.box(AppConstants.appHiveBox);
  TextEditingController searchController = TextEditingController();
  List productsHiveList = [];
  List companiesList = [];
  List filteredProductsList = [];
  bool isDataLoaded = false;
  bool firstTimeLoading = true;

  Future<bool> getSpecialOffersFunc() async {
    try {
      print('getSpecialOffersFunc() CALLED!!!');

      String apiUrl =
          '${ApiStrings.hostNameUrl}${ApiStrings.getSpecialOffersUrl}';

      var prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      // print('getSpecialOffers() response.body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == '200') {
          specialOffersImagesList = responseData['specialOffers'];

          return true;
        }
      }
      return false;
    } catch (e) {
      print('getSpecialOffersFunc() error ----------------------------> $e');
      return false;
    }
  }

  Future<bool> getProductsFunc() async {
    try {
      print('getProductsFunc() CALLED!!!');

      String apiUrl = '${ApiStrings.hostNameUrl}${ApiStrings.getProductsUrl}';

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

        // print('getProductsFunc() response.body: ${response.body}');

        if (responseData['status'] == '200') {
          List productList = responseData['products'] as List;
          List companiesList = responseData['companies'] as List;

          myAppBox.put(AppConstants.productHiveKey, productList);
          myAppBox.put(AppConstants.companiesHiveKey, companiesList);

          return true;
        }
      }

      return false;
    } catch (e) {
      print('getProductsFunc() error -----------------------> $e');
      return false;
    }
  }

  filterProducts() {
    final String query = searchController.text.toLowerCase();

    filteredProductsList = productsHiveList.where((product) {
      final productName = product['productName'].toLowerCase();
      final productCompany = product['productCompany'].toLowerCase();
      final productCategory = product['productCategory'].toLowerCase();
      return productName.contains(query) ||
          productCompany.contains(query) ||
          productCategory.contains(query);
    }).toList();

    // print('filterProductList -------------------> $filteredProductsList');
  }

  late Future<bool> getTheSpecialOffersFunc;
  late Future<bool> getTheProductFunc;

  @override
  void initState() {
    super.initState();

    if (myAppBox.isNotEmpty) {
      productsHiveList = myAppBox.get(AppConstants.productHiveKey);
      companiesList = myAppBox.get(AppConstants.companiesHiveKey);
    }

    if (!isDataLoaded) {
      getTheSpecialOffersFunc = getSpecialOffersFunc();
      getTheProductFunc = getProductsFunc();
      isDataLoaded = true;
    }

    filteredProductsList = productsHiveList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: Future.wait([getTheProductFunc, getTheSpecialOffersFunc]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  searchController.text.isEmpty &&
                  firstTimeLoading == true) {
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
                      padding: AppConstants.defaultHorizontalPadding,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Visibility(
                              visible: searchController.text.isEmpty,
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 28,
                                    backgroundColor: AppConstants.kGrey2,
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      size: 34,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Good Morning 👋🏻',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Ayush Kharwal',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(flex: 4),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          NotificationScreen.routeName);
                                    },
                                    icon: const Icon(
                                      Icons.notifications_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(
                                              FavProductsScreen.routeName)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline_sharp,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: const SizedBox(height: 20),
                          ),
                          CustomTextField(
                            label: 'Search',
                            textEditingController: searchController,
                            prefixIcon: const Icon(Icons.search),
                            onChanged: (String s) {
                              setState(() {
                                filterProducts();
                              });
                              firstTimeLoading = false;
                            },
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: const SizedBox(height: 10),
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: Row(
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
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: const SizedBox(height: 10),
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: Container(
                              height: 160,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: AppConstants.kGrey1,
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
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: const SizedBox(height: 20),
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: GridView.builder(
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
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductsByCategoryScreen.routeName,
                                      arguments: companiesList[index],
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: const EdgeInsets.all(18),
                                        child: SvgPicture.network(
                                          companiesList[index]
                                              ['companyImagePath'],
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
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: const SizedBox(height: 10),
                          ),
                          Visibility(
                            visible: searchController.text.isEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Most Popular',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                          ),
                          const SizedBox(height: 10),
                          ProductsGridList(
                            filteredProductsList: filteredProductsList,
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

class ProductsGridList extends StatelessWidget {
  const ProductsGridList({
    super.key,
    required this.filteredProductsList,
  });

  final List filteredProductsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 2 / 2.7,
      ),
      itemCount: filteredProductsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              AddToCartScreen.routeName,
              arguments: filteredProductsList[index],
            );
          },
          child: ProductGridTile(
            product: filteredProductsList[index],
          ),
        );
      },
    );
  }
}
