import 'package:flutter/material.dart';
import 'package:grocery_admin_app/widgets/my_drawer.dart';
import 'package:grocery_admin_app/widgets/myappbar.dart';
import 'package:grocery_admin_app/widgets/products_widget.dart';

class ViewAllOrderScreen extends StatefulWidget {
  const ViewAllOrderScreen({super.key});

  @override
  State<ViewAllOrderScreen> createState() => _ViewAllOrderScreenState();
}

class _ViewAllOrderScreenState extends State<ViewAllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myappbar(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return ProductWidget();
        },
      ),
    );
  }
}
