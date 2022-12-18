import 'package:flutter/material.dart';

import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: "MarketSans",
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(primary: const Color.fromRGBO(48, 85, 102, 1))
              .copyWith(secondary: Colors.green)),
      home: ProductOverviewScreen(),
    );
  }
}
