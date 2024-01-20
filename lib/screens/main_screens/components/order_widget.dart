import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/utils/helper_method.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({
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
    required this.deleteFunc,
    this.onTapFunc,
    this.isInViewOrder = false,
    this.retailerId = '',
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
  final Map<dynamic, dynamic> wholeProduct;
  var deleteFunc;
  var onTapFunc;
  bool isInViewOrder;
  String retailerId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
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
                              onPressed: deleteFunc,
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$productColor | Size = $productSize ',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: isInViewOrder ? '| qty = $quantity' : '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  status ?? const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$retail',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      mainButton,
                    ],
                  ),
                  isInViewOrder
                      ? Text(
                          'retaier\'s contact: $retailerId',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
