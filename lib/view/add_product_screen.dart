// prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_app/controller/loading_controller.dart';
import 'package:grocery_admin_app/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();

  String catValue = "Vegetables";
  int groupValue = 1;
  bool isPiece = false;
  File? pickedImage;
  String? imageUrl;
  void clearForm() {
    isPiece = false;
    groupValue = 1;
    productName.clear();
    price.clear();
    setState(() {
      pickedImage = null;
    });
  }

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
                                print(catValue);
                              },
                              dropdownMenuEntries: [
                                const DropdownMenuEntry(
                                    value: "Vegetables", label: "Vegetables"),
                                const DropdownMenuEntry(
                                    value: "Fruits", label: "Fruits"),
                                const DropdownMenuEntry(
                                    value: "Grains", label: "Grains"),
                                const DropdownMenuEntry(
                                    value: "Nuts", label: "Nuts"),
                                const DropdownMenuEntry(
                                    value: "Herbs", label: "Herbs"),
                                const DropdownMenuEntry(
                                    value: "Spices", label: "Spices"),
                              ]),
                        ],
                      )
                    ],
                  ),
                  const Text("Measure unit *"),
                  Row(
                    children: [
                      const Text("kg"),
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
                      const Text("Piece"),
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
                      Flexible(
                          child: pickedImage == null
                              ? _dottedBorder()
                              : Image.file(pickedImage!)),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              pickedImage = null;
                              print(pickedImage);
                            });
                          },
                          child: const Text("clear"))
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
                          onPressed: () => clearForm(),
                          icon: const Icon(Icons.warning),
                          label: const Text(
                            "Clear Form",
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
                              final uuid = const Uuid().v4();
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child("productImage")
                                  .child("$uuid.jpg");
                              await ref.putFile(pickedImage!);
                              imageUrl = await ref.getDownloadURL();

                              await FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(uuid)
                                  .set({
                                "id": uuid,
                                "title": productName.text,
                                "price": price.text,
                                "salePrice": 0.1,
                                "imageUrl": imageUrl,
                                "categoryName": catValue,
                                "isOnSale": false,
                                "isPiece": isPiece,
                                "createdAt": Timestamp.now()
                              });
                              loadingStateController.changeLoadingState(false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Successfully added")));
                              clearForm();
                            } on FirebaseException catch (error) {
                              loadingStateController.changeLoadingState(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Durations.extralong1,
                                      content: Text(error.message!)));
                            } catch (error) {
                              loadingStateController.changeLoadingState(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(milliseconds: 500),
                                      content:
                                          Text("You need to fill everything")));
                            } finally {
                              loadingStateController.changeLoadingState(false);
                            }
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text(
                            "Upload",
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
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _dottedBorder() {
    return DottedBorder(
      padding: const EdgeInsets.all(100),
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: [6, 7],
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
