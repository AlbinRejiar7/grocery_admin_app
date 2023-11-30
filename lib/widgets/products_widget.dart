// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(5),
      height: size.width * 0.5,
      width: size.width * 0.5,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(82, 137, 192, 64),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  child: Image.network(
                      "https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png")),
              Spacer(),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {},
                          child: Text("Edit"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          value: 2,
                        )
                      ])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "\$0.98",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "\$2.5",
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  )
                ],
              ),
              Text(
                "1Kg",
                style: TextStyle(fontWeight: FontWeight.w800),
              )
            ],
          ),
          Text(
            "Productname",
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
