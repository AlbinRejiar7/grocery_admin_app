// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String catValue = "Vegetables";
  int groupValue = 1;
  bool isPiece = false;
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        // color: Colors.amberAccent,
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product title *"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    filled: true,
                    fillColor: Color.fromARGB(118, 105, 98, 98),
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price in  \$ *"),
                    SizedBox(
                      width: size.width * 0.2,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Price",
                          filled: true,
                          fillColor: Color.fromARGB(118, 105, 98, 98),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Product Catagory *"),
                    DropdownMenu(
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          fillColor: Color.fromARGB(118, 105, 98, 98),
                        ),
                        initialSelection: catValue,
                        onSelected: (value) {
                          setState(() {
                            catValue = value!;
                          });
                          print(catValue);
                        },
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                              value: "Vegetables", label: "Vegetables"),
                          DropdownMenuEntry(value: "Fruits", label: "Fruits"),
                          DropdownMenuEntry(value: "Grains", label: "Grains"),
                          DropdownMenuEntry(value: "Nuts", label: "Nuts"),
                          DropdownMenuEntry(value: "Herbs", label: "Herbs"),
                          DropdownMenuEntry(value: "Spices", label: "Spices"),
                        ]),
                  ],
                )
              ],
            ),
            Text("Measure unit *"),
            Row(
              children: [
                Text("kg"),
                Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = 1;
                        isPiece = false;
                      });
                    }),
                Text("Piece"),
                Radio(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = 2;
                        isPiece = true;
                      });
                    }),
              ],
            ),
            Row(
              children: [
                Flexible(child: Center(child: _dottedBorder())),
                Column(
                  children: [
                    TextButton(onPressed: () {}, child: Text("clear")),
                    TextButton(onPressed: () {}, child: Text("Upload image"))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _dottedBorder() {
    return DottedBorder(
      padding: EdgeInsets.all(100),
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: [6, 7],
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              Icon(
                Icons.image_outlined,
                size: 80,
              ),
              TextButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  child: Text("CHOOSE AN IMAGE"))
            ],
          )),
    );
  }
}
