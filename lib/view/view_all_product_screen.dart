import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_admin_app/widgets/products_widget.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({
    super.key,
  });

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  String query = "";
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green[900],
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  hintText: "Search"),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: query.isEmpty
                    ? productsCollection.snapshots()
                    : productsCollection
                        .where('title', isGreaterThanOrEqualTo: query)
                        .where('title', isLessThan: '${query}z')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(
                      color: Colors.black,
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      "NO PRODUCTS",
                      style: TextStyle(fontSize: 40),
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                          id: snapshot.data!.docs[index]["id"],
                        );
                      },
                    );
                  } else {
                    return const Text("Something wrong");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
