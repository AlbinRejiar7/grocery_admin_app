//prefer_const_constructors, use_build_context_synchronously

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_app/controller/loading_controller.dart';
import 'package:grocery_admin_app/view/home_screen.dart';
import 'package:grocery_admin_app/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductEditingScreen extends StatefulWidget {
  const ProductEditingScreen({
    super.key,
    required this.title,
    required this.price,
    required this.categoryName,
    required this.isOnsale,
    required this.salePrice,
    required this.isPiece,
    required this.imageUrl,
    required this.id,
  });
  final String title;
  final String price;
  final String categoryName;
  final double salePrice;
  final bool isOnsale;
  final bool isPiece;
  final String imageUrl;
  final String id;

  @override
  State<ProductEditingScreen> createState() => _ProductEditingScreenState();
}

class _ProductEditingScreenState extends State<ProductEditingScreen> {
  @override
  void dispose() {
    productName.dispose();
    price.dispose();
    onsaleController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    productName.text = widget.title;
    price.text = widget.price;
    onsaleController.text = widget.salePrice.toStringAsFixed(2);
    imageUrl = widget.imageUrl;
    catValue = widget.categoryName;
    isOnSale = widget.isOnsale;
    isPiece = widget.isPiece;
  }

  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController onsaleController = TextEditingController();
  bool isOnSale = false;
  String catValue = "Vegetables";
  bool isPiece = false;
  File? pickedImage;
  String? imageUrl;
  int groupValue = 1;

  bool iStapped = false;

  @override
  Widget build(BuildContext context) {
    var loadingStateController = Provider.of<LoadingController>(context);
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: loadingStateController.isLoading,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Product title *"),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: productName,
                        decoration: const InputDecoration(
                          hintText: "Product Name",
                          filled: true,
                          fillColor: Color.fromARGB(118, 105, 98, 98),
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Price in  ₹ *"),
                          SizedBox(
                            width: size.width * 0.2,
                            child: TextField(
                              controller: price,
                              decoration: const InputDecoration(
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
                          const Text("Product Catagory *"),
                          DropdownMenu(
                              inputDecorationTheme: const InputDecorationTheme(
                                filled: true,
                                fillColor: Color.fromARGB(118, 105, 98, 98),
                              ),
                              initialSelection: catValue,
                              onSelected: (value) {
                                setState(() {
                                  catValue = value!;
                                });
                              },
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: "Vegetables", label: "Vegetables"),
                                DropdownMenuEntry(
                                    value: "Fruits", label: "Fruits"),
                                DropdownMenuEntry(
                                    value: "Grains", label: "Grains"),
                                DropdownMenuEntry(value: "Nuts", label: "Nuts"),
                                DropdownMenuEntry(
                                    value: "Herbs", label: "Herbs"),
                                DropdownMenuEntry(
                                    value: "Spices", label: "Spices"),
                              ]),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Is this product on sale?"),
                      Checkbox(
                          value: isOnSale,
                          onChanged: (value) {
                            setState(() {
                              isOnSale = value!;
                            });
                          }),
                    ],
                  ),
                  Visibility(
                    visible: isOnSale,
                    child: SizedBox(
                      width: size.width * 0.3,
                      child: TextField(
                        controller: onsaleController,
                        decoration: const InputDecoration(
                          hintText: "On Sale Price",
                          filled: true,
                          fillColor: Color.fromARGB(118, 105, 98, 98),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Text("Measure unit *"),
                  Row(
                    children: [
                      const Text("kg"),
                      Checkbox(
                          value: !isPiece,
                          onChanged: (value) {
                            setState(() {
                              isPiece = !value!;
                            });
                          }),
                      const Text("Piece"),
                      Checkbox(
                          value: isPiece,
                          onChanged: (value) {
                            setState(() {
                              isPiece = value!;
                            });
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      iStapped
                          ? Flexible(
                              child: pickedImage == null
                                  ? _dottedBorder()
                                  : Image.file(fit: BoxFit.fill, pickedImage!))
                          : Flexible(
                              child: imageUrl == null
                                  ? _dottedBorder()
                                  : Image.network(fit: BoxFit.fill, imageUrl!)),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  pickedImage = null;
                                  imageUrl = null;
                                  iStapped = true;
                                });
                              },
                              child: const Text("clear")),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          style: const ButtonStyle(
                              iconColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          "Are you sure you want to delete this product ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No")),
                                        TextButton(
                                            onPressed: () async {
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection("products")
                                                    .doc(widget.id)
                                                    .delete();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Successfully Deleted")));
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()));
                                              } on FirebaseException catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text(e.message!)));
                                              }
                                            },
                                            child: const Text("Yes"))
                                      ],
                                    ));
                          },
                          icon: const Icon(Icons.warning),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton.icon(
                          style: const ButtonStyle(
                              iconColor: MaterialStatePropertyAll(Colors.white),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.green,
                              )),
                          onPressed: () async {
                            loadingStateController.changeLoadingState(true);
                            try {
                              final storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child("productImage")
                                  .child("${widget.id}.jpg");

                              if (pickedImage != null) {
                                var uploadTaskSnapshot =
                                    await storageRef.putFile(pickedImage!);
                                imageUrl = await uploadTaskSnapshot.ref
                                    .getDownloadURL();
                                await FirebaseFirestore.instance
                                    .collection("products")
                                    .doc(widget.id)
                                    .update({
                                  "title": productName.text,
                                  "price": price.text,
                                  "salePrice":
                                      double.parse(onsaleController.text),
                                  "imageUrl": imageUrl,
                                  "categoryName": catValue,
                                  "isOnSale": isOnSale,
                                  "isPiece": isPiece,
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeScreen()));
                              } else {
                                await FirebaseFirestore.instance
                                    .collection("products")
                                    .doc(widget.id)
                                    .update({
                                  "title": productName.text,
                                  "price": price.text,
                                  "salePrice":
                                      double.parse(onsaleController.text),
                                  "imageUrl": imageUrl,
                                  "categoryName": catValue,
                                  "isOnSale": isOnSale,
                                  "isPiece": isPiece,
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }

                              loadingStateController.changeLoadingState(false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Successfully Updated")));
                            } on FirebaseException catch (error) {
                              loadingStateController.changeLoadingState(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.message!)));
                            } catch (error) {
                              loadingStateController.changeLoadingState(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            } finally {
                              loadingStateController.changeLoadingState(false);
                            }
                          },
                          icon: const Icon(Icons.update),
                          label: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
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
      } else {}
    });
  }

  Widget _dottedBorder() {
    return DottedBorder(
      padding: const EdgeInsets.all(100),
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [6, 7],
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              const Icon(
                Icons.image_outlined,
                size: 80,
              ),
              TextButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  child: const Text("CHOOSE AN IMAGE"))
            ],
          )),
    );
  }
}
