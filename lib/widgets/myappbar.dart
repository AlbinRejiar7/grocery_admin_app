import 'package:flutter/material.dart';

AppBar myappbar() {
  return AppBar(
    title: TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 233, 213, 213),
          border: InputBorder.none,
          hintText: "Search"),
    ),
    actions: [
      IconButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7))),
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () {},
          icon: Icon(Icons.search))
    ],
  );
}
