import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
  const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
        body: screens[currentIndex],

        bottomNavigationBar:
        BottomNavigationBar(

            currentIndex: currentIndex,

            type:
            BottomNavigationBarType.fixed,

            selectedItemColor:
            Colors.red,

            unselectedItemColor:
            Colors.grey,

            showSelectedLabels: false,

            showUnselectedLabels: false,

            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "",
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "",
              ),

              BottomNavigationBarItem(
                label: "",
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    const Icon(
                      Icons.shopping_cart,
                    ),

                    if (provider.cartCount > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${provider.cartCount}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "",
              ),
            ],
        ),
    );
  }
}