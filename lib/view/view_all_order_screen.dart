import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_admin_app/widgets/orders_widget.dart';

class ViewAllOrderScreen extends StatefulWidget {
  const ViewAllOrderScreen({super.key});

  @override
  State<ViewAllOrderScreen> createState() => _ViewAllOrderScreenState();
}

class _ViewAllOrderScreenState extends State<ViewAllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL ORDERS"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("orders").snapshots(),
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
            } else if (snapshot.connectionState == ConnectionState.active) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrdersWidget(
                    address: snapshot.data!.docs[index]["address"],
                    imageUrl: snapshot.data!.docs[index]["imageUrl"],
                    userId: snapshot.data!.docs[index]["userId"],
                    productId: snapshot.data!.docs[index]["productId"],
                    price: snapshot.data!.docs[index]["price"],
                    totalPrice: snapshot.data!.docs[index]["totalPrice"],
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
    );
  }
}
