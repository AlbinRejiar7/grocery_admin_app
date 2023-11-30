// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
            height: size.width * 0.2,
            width: size.width * 0.2,
            child: Image.network(
                "https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png")),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "12x fpr \$19.9",
              style: TextStyle(fontSize: 20),
            ),
            Text("user name"),
            Text("20/03/2022")
          ],
        )
      ],
    );
  }
}
