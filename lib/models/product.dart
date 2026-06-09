class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;

  bool isFavorite;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    this.isFavorite = false,
    this.quantity = 1,
  });

  factory Product.fromJson(
      Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      image: json["thumbnail"],
      category: json["category"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "thumbnail": image,
      "category": category,
      "quantity": quantity,
    };
  }
}