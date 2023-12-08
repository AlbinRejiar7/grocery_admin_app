import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_admin_app/view/add_product_screen.dart';
import 'package:grocery_admin_app/view/view_all_product_screen.dart';
import 'package:grocery_admin_app/widgets/orders_widget.dart';
import 'package:grocery_admin_app/widgets/products_widget.dart';

import '../widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Admin App",
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ViewAllProductScreen()));
                      },
                      icon: const Icon(Icons.file_copy),
                      label: const Text("View All Products")),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddProductScreen()));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Prodcut")),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Latest Products",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("products")
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
                        itemCount: snapshot.data!.docs.length >= 4
                            ? 4
                            : snapshot.data!.docs.length,
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
              const Text(
                "Recent Orders",
                style: TextStyle(fontSize: 25),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("orders")
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
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length > 4
                            ? 4
                            : snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OrdersWidget(
                            address: snapshot.data!.docs[index]["address"],
                            imageUrl: snapshot.data!.docs[index]["imageUrl"],
                            userId: snapshot.data!.docs[index]["userId"],
                            productId: snapshot.data!.docs[index]["productId"],
                            price: snapshot.data!.docs[index]["price"],
                            totalPrice: snapshot.data!.docs[index]
                                ["totalPrice"],
                            userName: snapshot.data!.docs[index]["userName"],
                            quantity: snapshot.data!.docs[index]["quantity"],
                            ordeDate: snapshot.data!.docs[index]["orderDate"],
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
      ),
    );
  }
}
