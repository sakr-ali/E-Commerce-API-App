import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        "title": "Beauty",
        "icon": Icons.face,
      },
      {
        "title": "Fragrances",
        "icon": Icons.spa,
      },
      {
        "title": "Furniture",
        "icon": Icons.chair,
      },
      {
        "title": "Groceries",
        "icon": Icons.shopping_basket,
      },
      {
        "title": "Smartphones",
        "icon": Icons.phone_android,
      },
      {
        "title": "Laptops",
        "icon": Icons.laptop,
      },
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Categories",
          ),
        ),

        body: Padding(
            padding: const EdgeInsets.all(16),

            child: GridView.builder(
                itemCount: categories.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 12,

                  mainAxisSpacing: 12,
                ),

                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${category["title"]} selected",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor:
                            Colors.red.shade50,
                            child: Icon(
                              category["icon"],
                              color: Colors.red,
                              size: 35,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            category["title"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
            ),
        ),
    );
  }
}