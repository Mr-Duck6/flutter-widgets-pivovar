import 'package:flutter/material.dart';
import 'package:flutter_widgets_pivovar/models/product.dart';
import 'package:flutter_widgets_pivovar/models/user.dart';

class AppState extends ChangeNotifier {
  // Single source of truth: приватні списки та дані
  final List<Product> _favoriteProducts = [];
  User? _currentUser;
  int _cartItemsCount = 0;

  // Гетери для безпечного читання стану ззовні
  List<Product> get favoriteProducts => List.unmodifiable(_favoriteProducts);
  User? get currentUser => _currentUser;
  int get cartItemsCount => _cartItemsCount;

  // Сетер для користувача
  void setUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  // Методи керування обраними товарами
  void toggleFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  // Метод додавання в кошик
  void addToCart(Product product) {
    _cartItemsCount++;
    notifyListeners();
  }

  // Перевірка чи товар в обраному
  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }
}
