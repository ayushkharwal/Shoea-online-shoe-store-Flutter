import 'package:hive/hive.dart';

part 'PlaceOrderItem.g.dart';

@HiveType(typeId: 0)
class PlaceOrderItem extends HiveObject {
  @HiveField(0)
  String productName;

  @HiveField(1)
  String productSize;

  @HiveField(2)
  String productColor;

  @HiveField(3)
  String productRetail;

  @HiveField(4)
  String retialerId;

  @HiveField(5)
  String productId;

  @HiveField(6)
  String quantity;

  @HiveField(7)
  String retailerName;

  @HiveField(8)
  String imageLink;

  PlaceOrderItem({
    required this.productName,
    required this.productSize,
    required this.productColor,
    required this.productRetail,
    required this.retialerId,
    required this.productId,
    required this.quantity,
    required this.retailerName,
    required this.imageLink,
  });

  // Create an instance from a JSON object
  factory PlaceOrderItem.fromJson(Map<String, dynamic> json) {
    return PlaceOrderItem(
      productName: json['productName'],
      productSize: json['productSize'],
      productColor: json['productColor'],
      productRetail: json['productRetail'],
      retialerId: json['retialerId'],
      productId: json['productId'],
      quantity: json['quantity'],
      retailerName: json['retailerName'],
      imageLink: json['imageLink'],
    );
  }

  // Convert the object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productSize': productSize,
      'productColor': productColor,
      'productRetail': productRetail,
      'retialerId': retialerId,
      'productId': productId,
      'quantity': quantity,
      'retailerName': retailerName,
      'imageLink': imageLink,
    };
  }
}
