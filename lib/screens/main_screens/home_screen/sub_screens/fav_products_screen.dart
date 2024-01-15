import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoea_flutter/common/widgets/product_grid_tile.dart';
import 'package:shoea_flutter/constants.dart';

class FavProductsScreen extends StatefulWidget {
  static const String routeName = '/fav_products';

  const FavProductsScreen({super.key});

  @override
  State<FavProductsScreen> createState() => _FavProductsScreenState();
}

class _FavProductsScreenState extends State<FavProductsScreen> {
  List favouriteProductsList = [];

  getFavouriteProducts() {
    Box box = Hive.box(AppConstants.appHiveBox);

    favouriteProductsList = box.get(AppConstants.favProductsHiveKey) ?? [];
  }

  @override
  void initState() {
    super.initState();

    getFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: favouriteProductsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 2 / 2.7,
          ),
          itemBuilder: (context, index) {
            return ProductGridTile(product: favouriteProductsList[index]);
          },
        ),
      ),
    );
  }
}
