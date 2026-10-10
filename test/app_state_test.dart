import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widgets_pivovar/models/product.dart';
import 'package:flutter_widgets_pivovar/utils/app_state.dart';

void main() {
  group('AppState Tests', () {
    test('Initial state should be empty/null', () {
      final state = AppState();
      expect(state.cartItemsCount, 0);
      expect(state.favoriteProducts,isEmpty);
      expect(state.currentUser, null);
    });

    test('Adding product to cart increments counter', () {
      final state = AppState();
      const product = Product(
        id: '1',
        name: 'Test Product',
        price: 99.99,
        imageUrl: '',
      );

      state.addToCart(product);

      expect(state.cartItemsCount, 1);
    });

    test('Toggling favorite adds and removes product', () {
      final state = AppState();
      const product = Product(
        id: '1',
        name: 'Test Product',
        price: 99.99,
        imageUrl: '',
      );

      state.toggleFavorite(product);
      expect(state.isFavorite(product), true);
      expect(state.favoriteProducts.length, 1);

      state.toggleFavorite(product);
      expect(state.isFavorite(product), false);
      expect(state.favoriteProducts.length, 0);
    });
  });
}