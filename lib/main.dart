import 'package:flutter/material.dart';
import 'package:grocery_admin_app/controller/dark_theme_controller.dart';
import 'package:grocery_admin_app/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'constants/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DarkThemeProvider())
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Grocery Admin App',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
