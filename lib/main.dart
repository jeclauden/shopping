import 'package:flutter/material.dart';
import 'providers/cart.dart';
import './screens/product_detail_screen.dart';
import 'providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: "Lunchtype",
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // Use create if instantiating objects
          create: ((context) => ProductsProvider()),
        ),
        ChangeNotifierProvider(
          // Use create if instantiating objects
          create: ((context) => Cart()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(primary: const Color.fromRGBO(48, 85, 102, 1))
                .copyWith(secondary: Colors.green)),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen()
        },
      ),
    );
  }
}
