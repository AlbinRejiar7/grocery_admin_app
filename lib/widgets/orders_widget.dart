import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  final String imageUrl, userId, productId, userName, address;
  final double price, totalPrice;
  final int quantity;
  final Timestamp ordeDate;

  const OrdersWidget(
      {super.key,
      required this.imageUrl,
      required this.userId,
      required this.productId,
      required this.price,
      required this.totalPrice,
      required this.userName,
      required this.quantity,
      required this.ordeDate,
      required this.address});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
              height: size.width * 0.2,
              width: size.width * 0.2,
              child: Image.network(imageUrl)),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${quantity.toString()}x for ₹ ${price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20),
              ),
              Text("Ordered By $userName"),
              Text("Address : $address"),
              Text("Order Date:${ordeDate.toDate().toUtc().toLocal()}")
            ],
          )
        ],
      ),
    );
  }
}
