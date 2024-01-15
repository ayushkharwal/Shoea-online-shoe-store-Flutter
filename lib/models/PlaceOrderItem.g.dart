// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaceOrderItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceOrderItemAdapter extends TypeAdapter<PlaceOrderItem> {
  @override
  final int typeId = 0;

  @override
  PlaceOrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceOrderItem(
      productName: fields[0] as String,
      productSize: fields[1] as String,
      productColor: fields[2] as String,
      productRetail: fields[3] as String,
      retialerId: fields[4] as String,
      productId: fields[5] as String,
      quantity: fields[6] as String,
      retailerName: fields[7] as String,
      imageLink: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceOrderItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productSize)
      ..writeByte(2)
      ..write(obj.productColor)
      ..writeByte(3)
      ..write(obj.productRetail)
      ..writeByte(4)
      ..write(obj.retialerId)
      ..writeByte(5)
      ..write(obj.productId)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.retailerName)
      ..writeByte(8)
      ..write(obj.imageLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceOrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
