// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_app/view/product_editing_screen.dart';
import 'package:lottie/lottie.dart';

class ProductWidget extends StatefulWidget {
  final String id;

  const ProductWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String? imageUrl;
  String price = "";
  double salePrice = 0.0;
  String title = "";
  bool isOnsale = false;
  bool isPiece = false;
  String categoryName = "";
  @override
  void initState() {
    super.initState();
    getProducts(widget.id, context);
  }

  Future<void> getProducts(String id, BuildContext context) async {
    try {
      DocumentSnapshot productDoc =
          await FirebaseFirestore.instance.collection("products").doc(id).get();
      imageUrl = productDoc.get("imageUrl");
      price = productDoc.get("price");
      salePrice = productDoc.get("salePrice");
      title = productDoc.get("title");
      isOnsale = productDoc.get("isOnSale");
      isPiece = productDoc.get("isPiece");
      categoryName = productDoc.get("categoryName");
      setState(() {});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductEditingScreen(
                    title: title,
                    price: price,
                    categoryName: categoryName,
                    isOnsale: isOnsale,
                    salePrice: salePrice,
                    isPiece: isPiece,
                    imageUrl: imageUrl!,
                    id: widget.id)));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: size.width * 0.5,
        width: size.width * 0.5,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(82, 137, 192, 64),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageUrl != null
                    ? SizedBox(
                        height: size.width * 0.25,
                        width: size.width * 0.25,
                        child: Image.network(imageUrl!),
                      )
                    : SizedBox(
                        height: size.width * 0.25,
                        width: size.width * 0.25,
                        child:
                            Lottie.asset("assets/icons/anim/imageLoading.json"),
                      ),
                const Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "₹ ${isOnsale ? salePrice.toStringAsFixed(2) : price}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Visibility(
                      visible: isOnsale,
                      child: Text(
                        "₹ ${price}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                ),
                Text(
                  "1 ${isPiece ? "piece" : "kg"}",
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
