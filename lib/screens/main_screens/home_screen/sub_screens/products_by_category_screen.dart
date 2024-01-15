import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoea_flutter/common/widgets/product_grid_tile.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/add_to_cart_screen.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  static const String routeName = '/products_by_category';

  const ProductsByCategoryScreen({
    super.key,
    required this.company,
  });

  final Map<dynamic, dynamic> company;

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  List<dynamic> filteredProducts = [];

  fetchRequriedProducts() {
    Box appBox = Hive.box(AppConstants.appHiveBox);

    var allProducts = appBox.get(AppConstants.productHiveKey);

    if (allProducts != null && allProducts is List) {
      setState(() {
        filteredProducts = allProducts.where((product) {
          return product['productCompany'] == widget.company['companyName'] ||
              product['productCategory'] == widget.company['companyName'];
        }).toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchRequriedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company['companyName']),
        surfaceTintColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 2 / 2.7,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          var product = filteredProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AddToCartScreen.routeName,
                arguments: product,
              );
            },
            child: ProductGridTile(
              product: product,
            ),
          );
        },
      ),
    );
  }
}
