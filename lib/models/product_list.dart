import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://shop-a9cbf-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  /// checks to see if product submitted(_submitForm()) already had an id and sends product information
  /// if it has an Id it updates products' details otherwise it creates a new one
  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  /// using product's information from saveProduct it creates a new product
  void addProduct(Product product) {
    http.post(
      Uri.parse('$_baseUrl/products.json'),
      body: jsonEncode({
        "name" : product.name,
        "description" : product.description,
        "price" : product.price,
        "imageUrl" : product.imageUrl,
        "isFavorite" : product.isFavorite,
      })
    );

    _items.add(product);
    notifyListeners();
  }

  /// using product's information from saveProduct it changes the product's details using the id to identify
  /// it's index
  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if(index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }
  /// when user presses the yes button when trying to delete a product this function is called
  /// passing the product's id
  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);
    if(index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
