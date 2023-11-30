// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grocery_admin_app/controller/dark_theme_controller.dart';
import 'package:grocery_admin_app/view/add_product_screen.dart';
import 'package:grocery_admin_app/widgets/orders_widget.dart';
import 'package:grocery_admin_app/widgets/products_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/my_drawer.dart';
import '../widgets/myappbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: myappbar(),
        body: ListView(
          children: [
            Text(
              "Latest Products",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.file_copy),
                    label: Text("View All")),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductScreen()));
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add Prodcut")),
              ],
            ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget();
                },
              ),
            ),
            Flexible(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return OrdersWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
