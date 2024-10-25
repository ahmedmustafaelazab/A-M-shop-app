import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/models/product_model.dart';

void main() {
  group('ProductModel', () {
    test('should create a valid ProductModel from JSON', () {
      final json = {
        'id': '1',
        'price': 100,
        'old_price': 120,
        'discount': 20,
        'image': 'https://example.com/image.jpg',
        'name': 'Test Product',
        'description': 'This is a test product',
        'in_favorites': true,
        'in_cart': false,
      };

      final productModel = ProductModel.fromJson(json: json);

      expect(productModel.id, '1');
      expect(productModel.price, 100);
      expect(productModel.oldPrice, 120);
      expect(productModel.discount, 20);
      expect(productModel.image, 'https://example.com/image.jpg');
      expect(productModel.name, 'Test Product');
      expect(productModel.description, 'This is a test product');
      expect(productModel.inFavorite, true);
      expect(productModel.inCart, false);
    });
  });
}

