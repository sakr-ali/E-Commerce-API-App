import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/navigation_screen.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final provider = ProductProvider();
        provider.fetchProducts();
        return provider;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce API",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const NavigationScreen(),
    );
  }
}

