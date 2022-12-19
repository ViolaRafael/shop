import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  /// get the total number of items(not quantity) to use for the number above cart drawer
  int get itemsCount {
    return _items.length;
  }

  /// gets the price of buying the full cart to show in Cart tab and to save for Orders' tab
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price* cartItem.quantity;
    });
    return total;
  }

  /// if select product is already in the cart, increase quantity of product by 1;
  /// otherwise add selected product to cart
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            price: product.price),
      );
    }
    /// notifies Widgets with ChangeNotifier to reload their assets
    notifyListeners();
  }

  /// removes selected id with id provided, it's used with a onDismissed
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  /// if select product is already in the cart, decrease quantity of product by 1;
  /// otherwise remove selected product from cart
  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)) {
      return;
    }

    if(_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
            (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  /// clears list of full items, it's used after cart's products are saved in orders
  void clear() {
    _items = {};
    notifyListeners();
  }
}
