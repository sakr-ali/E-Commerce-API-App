import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "E-Commerce API",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: provider.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

              const Text(
              "Today's Deals",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Best products for you",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
                child: GridView.builder(

                    itemCount:
                    provider.products.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      crossAxisSpacing: 12,

                      mainAxisSpacing: 12,

                      childAspectRatio: 0.60,

                    ),

                    itemBuilder:
                        (context, index) {

                      Product product =
                      provider.products[index];

                      return Container(

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                            boxShadow: [

                              BoxShadow(

                                color: Colors.grey
                                    .withOpacity(0.2),

                                blurRadius: 5,

                                offset:
                                const Offset(
                                  0,
                                  2,
                                ),

                              ),

                            ],

                          ),

                          child: Column(

                              children: [

                              Expanded(

                              flex: 5,

                              child: Stack(

                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius.only(
                                        topLeft:
                                        Radius.circular(18),
                                        topRight:
                                        Radius.circular(18),
                                      ),
                                      child:CachedNetworkImage(
                                          imageUrl: product.image,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,

                                          placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),

                                          errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.image_not_supported,
                                            size: 40,
                                          ),
                                        ),
                                    ),

                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                        Colors.white,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            product.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            provider.toggleFavorite(
                                              product,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                              ),
                          ),

                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                  Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style:
                                  const TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  "\$${product.price}",
                                  style:
                                  const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const Spacer(),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          provider.addToCart(product);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${product.title} added to cart",
                                              ),
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "Add To Cart",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                              ],
                          ),
                      );
                        },
                ),
            ),
              ],
            ),
        ),
    );
  }
}