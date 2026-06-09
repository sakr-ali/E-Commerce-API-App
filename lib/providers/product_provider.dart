import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];
  final List<Product> _cart = [];

  bool isLoading = false;

  List<Product> get products => _products;
  List<Product> get cart => _cart;
  int get cartCount => _cart.length;
  List<Product> get favorites =>
      _products.where((e) => e.isFavorite).toList();

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    saveFavorites();
    saveProducts();
    notifyListeners();
  }
  void addToCart(Product product){
    if(_cart.contains(product)){
      product.quantity++;
    }else{
      product.quantity=1;
      _cart.add(product);
    }
    saveProducts();
    saveCart();
    notifyListeners();
  }

  void removeFromCart(Product product){
    _cart.remove(product);
    saveProducts();
    saveCart();
    notifyListeners();
  }
  void increaseQuantity(Product product){
    product.quantity++;
    saveProducts();
    saveCart();
    notifyListeners();
  }

  void decreaseQuantity(Product product){
    if(product.quantity>1){
      product.quantity--;
    }else{
      _cart.remove(product);
    }
    saveProducts();
    saveCart();
    notifyListeners();
  }
  double get totalPrice {
    double total = 0;

    for (var product in _cart) {
      total += product.price * product.quantity;
    }
    return total;
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      debugPrint("START API");

      final response = await http.get(
        Uri.parse(
          "https://dummyjson.com/products",
        ),
      );
      debugPrint(
        "STATUS CODE = ${response.statusCode}",
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data["products"];
        debugPrint(
          "PRODUCTS = ${list.length}",
        );
        _products.clear();
        _products.addAll(
          list.map<Product>(
                (e) => Product.fromJson(e),
          ),
        );
        await saveProducts();
        await loadFavorites();
        await loadCart();
      }
    } catch(e){
      debugPrint("ERROR=$e");
      await loadProducts();
      await loadFavorites();
      await loadCart();
    }
    isLoading = false;
    notifyListeners();
    debugPrint("FINISH API");
  }
  Future<void> saveProducts() async {
    final file = await _localFile();

    final data = _products
        .map((e) => e.toJson())
        .toList();

    await file.writeAsString(
      jsonEncode(data),
    );
  }
  Future<void> loadProducts() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) return;
      final text = await file.readAsString();
      final List list = jsonDecode(text);
      _products.clear();
      _products.addAll(
        list.map<Product>(
              (e) => Product.fromJson(e),
        ),
      );
      await loadFavorites();
      notifyListeners();
    } catch (e) {
      debugPrint("LOAD LOCAL ERROR = $e");
    }
  }
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<int> ids = favorites.map((e) => e.id).toList();
    await prefs.setString(
      "favorites",
      jsonEncode(ids),
    );
  }
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("favorites");
    if (data == null) return;
    List ids = jsonDecode(data);
    for (var product in _products) {
      product.isFavorite =
          ids.contains(product.id);
    }
    notifyListeners();
  }
  Future<void> saveCart() async{
    final prefs=await SharedPreferences.getInstance();
    final data=_cart.map((e)=>{
      "id":e.id,
      "quantity":e.quantity,
    }).toList();
    await prefs.setString(
      "cart",
      jsonEncode(data),
    );
  }
  Future<void> loadCart() async{
    final prefs=await SharedPreferences.getInstance();
    final data=prefs.getString("cart");
    if(data==null)return;
    final List list=jsonDecode(data);
    _cart.clear();
    for(var item in list){
      int id=item["id"];
      int qty=item["quantity"];
      int index=_products.indexWhere((e)=>e.id==id);
      if(index!=-1){
        _products[index].quantity=qty;
        _cart.add(_products[index]);
      }
    }
    notifyListeners();
  }
  Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/products.json");
  }

}