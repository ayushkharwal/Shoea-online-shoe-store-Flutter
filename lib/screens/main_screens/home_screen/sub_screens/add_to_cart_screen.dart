import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoea_flutter/common/widgets/custom_button.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/models/PlaceOrderItem.dart';
import 'package:shoea_flutter/utils/helper_method.dart';

class AddToCartScreen extends StatefulWidget {
  static const String routeName = '/add_to_cart';

  const AddToCartScreen({super.key, required this.product});

  final product;

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  final SizedBox _sizedBox20 = const SizedBox(height: 20);
  final SizedBox _sizedBox10 = const SizedBox(height: 10);

  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;

  String selectedColor = '';
  String selectSize = '';

  List<String> shoeSizes = [];
  List<String> shoeColor = [];

  int quantity = 1;

  List<String> splitAndTrim(String inputString) {
    List<String> splitStrings = inputString.split(',');

    List<String> trimmedList =
        splitStrings.map((s) => s.trim().toLowerCase()).toList();

    // print('trimmedList -----------------> $trimmedList');

    return trimmedList;
  }

  @override
  void initState() {
    super.initState();

    // print('widget.product -----------------------> ${widget.product}');

    if (widget.product['productDescription'].length > 150) {
      firstHalf = widget.product['productDescription'].substring(0, 150);
      secondHalf = widget.product['productDescription']
          .substring(150, widget.product['productDescription'].length);
    } else {
      firstHalf = widget.product['productDescription'];
      secondHalf = "";
    }

    shoeSizes = splitAndTrim(widget.product['productSizes']);
    shoeColor = splitAndTrim(widget.product['productColors']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: customBottomSheet(size.height),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: widget.product['productImages'].length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.product['productImages'][index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: _buildDots(),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sizedBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.product['productName'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline_rounded),
                      ),
                    ],
                  ),
                  const Divider(),
                  _sizedBox20,
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondHalf.isEmpty
                      ? Text(firstHalf)
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                          child: flag
                              ? Text(
                                  '$firstHalf....',
                                )
                              : Text(firstHalf + secondHalf),
                        ),
                  _sizedBox20,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _sizedBox10,
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              itemCount: shoeSizes.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectSize = shoeSizes[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectSize == shoeSizes[index]
                                          ? Colors.black
                                          : Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: 40,
                                    width: 40,
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        shoeSizes[index],
                                        style: TextStyle(
                                          color: selectSize == shoeSizes[index]
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Color',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _sizedBox10,
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              itemCount: shoeColor.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                var myColor = shoeColor[index];

                                Color myShoeColor =
                                    HelperMethod.getColorFromString(myColor);

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = myColor;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: myShoeColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: myColor == selectedColor
                                            ? Colors.amber
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _sizedBox20,
                  Row(
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppConstants.kGrey2,
                                  border: Border(
                                    left:
                                        BorderSide(color: AppConstants.kGrey3),
                                    right:
                                        BorderSide(color: AppConstants.kGrey3),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 6,
                                    bottom: 6,
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            top: 0,
                            bottom: 0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                setState(() {
                                  quantity = quantity + 1;
                                });
                              },
                              icon: const Icon(
                                Icons.add_rounded,
                                size: 27,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: -6,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity = quantity - 1;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.minimize_rounded,
                                size: 27,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _sizedBox20,
                  const Text(
                    "Retailer's Contact",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.product['retailerName'])
                ],
              ),
            ),
            SizedBox(height: size.height * 0.13),
          ],
        ),
      ),
    );
  }

  int _currentPage = 0;

  Row _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < widget.product['productImages'].length; i++) {
      dots.add(Container(
        margin: const EdgeInsets.all(5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? AppConstants.kPrimaryColor1
              : AppConstants.kGrey2,
        ),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }

  customBottomSheet(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$${widget.product["productRetail"]}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                width: 160,
                margin: const EdgeInsets.all(12),
                child: CustomButton(
                  label: 'Add to Cart',
                  onPress: () {
                    if (selectSize != '' && selectedColor != '') {
                      PlaceOrderItem placeOrderItem = PlaceOrderItem(
                        productName: widget.product['productName'],
                        productSize: selectSize,
                        productColor: selectedColor,
                        productRetail: widget.product['productRetail'],
                        retialerId: widget.product['retailerId'],
                        productId: widget.product['productId'],
                        quantity: quantity.toString(),
                        retailerName: widget.product['retailerName'],
                        imageLink: widget.product['productImages'][0],
                      );

                      Box box = Hive.box(AppConstants.appHiveBox);

                      List cartList =
                          box.get(AppConstants.cartProductHiveKey) ?? [];

                      List tempList = cartList;

                      bool productAlreadyInList = false;

                      if (cartList.isNotEmpty) {
                        for (var item in cartList) {
                          if (item.productId == placeOrderItem.productId) {
                            productAlreadyInList = true;

                            item.quantity = placeOrderItem.quantity;
                            item.productSize = placeOrderItem.productSize;
                            item.productColor = placeOrderItem.productColor;
                          }
                        }

                        if (!productAlreadyInList) {
                          tempList.add(placeOrderItem);
                        }
                      } else {
                        tempList.add(placeOrderItem);
                      }

                      cartList = tempList;

                      box.put(AppConstants.cartProductHiveKey, cartList);
                    } else if (selectSize == '' && selectedColor != '') {
                      HelperMethod.showSnackbar(
                        context,
                        const Text('Please select a size!'),
                      );
                    } else if (selectedColor == '' && selectSize != '') {
                      HelperMethod.showSnackbar(
                        context,
                        const Text('Please select a color!'),
                      );
                    } else {
                      HelperMethod.showSnackbar(
                        context,
                        const Text('Please select a size and a color!'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
