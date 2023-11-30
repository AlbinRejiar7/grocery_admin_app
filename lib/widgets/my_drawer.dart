// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_admin_app/view/home_screen.dart';
import 'package:grocery_admin_app/view/view_all_order_screen.dart';
import 'package:grocery_admin_app/view/view_all_product_screen.dart';
import 'package:provider/provider.dart';

import '../controller/dark_theme_controller.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset("assets/icons/groceries.png"),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        "Main",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.padding_rounded,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AllProductsScreen()));
                      },
                      child: Text(
                        "View All product",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ViewAllOrderScreen()));
                      },
                      child: Text(
                        "View all order",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SwitchListTile(
              secondary: Icon(themeController.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              title: Text(
                "Theme",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              value: themeController.getDarkTheme,
              onChanged: (value) {
                setState(() {
                  themeController.setDarkTheme = value;
                });
              })
        ],
      ),
    );
  }
}
