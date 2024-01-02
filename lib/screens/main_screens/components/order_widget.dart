import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    this.addWidget,
    this.status,
    required this.isActive,
    required this.mainButton,
  });

  final Widget? addWidget;
  final Widget? status;
  final Widget mainButton;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      margin: defaultHorizontalPadding,
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
              color: kGrey1,
              borderRadius: BorderRadius.circular(20),
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
                    const Text(
                      'Air Jordan 3 Retro',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 6,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Silver | Size = 41',
                      style: TextStyle(fontSize: 12),
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
    );
  }
}
