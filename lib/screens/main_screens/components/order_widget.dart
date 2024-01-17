import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/screens/main_screens/home_screen/sub_screens/add_to_cart_screen.dart';
import 'package:shoea_flutter/utils/helper_method.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    this.addWidget,
    this.status,
    required this.isActive,
    required this.mainButton,

    // Imp Stuff
    required this.label,
    required this.productColor,
    required this.productSize,
    required this.retail,
    required this.quantity,
    required this.productImage,
    required this.wholeProduct,
  });

  final Widget? addWidget;
  final Widget? status;
  final Widget mainButton;
  final bool isActive;

  final String label;
  final String productColor;
  final String productSize;
  final String retail;
  final String quantity;
  final String productImage;
  final Map<String, dynamic> wholeProduct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AddToCartScreen.routeName,
          arguments: wholeProduct,
        );
      },
      child: Container(
        height: 150,
        width: double.maxFinite,
        margin: AppConstants.defaultHorizontalPadding,
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
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: double.maxFinite,
              width: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppConstants.kGrey1,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(productImage),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppConstants.kGrey2,
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      isActive
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 6,
                        child: CircleAvatar(
                          backgroundColor:
                              HelperMethod.getColorFromString(productColor),
                          radius: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$productColor | Size = $productSize',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  status ?? const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$105.00',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      mainButton,
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
