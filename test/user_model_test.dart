import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create a valid UserModel from JSON', () {
      final json = {
        'name': 'John Doe',
        'image': 'https://example.com/image.jpg',
        'email': 'john@example.com',
        'phone': '1234567890',
        'token': 'abc123',
        'id': 1,
      };

      final userModel = UserModel.fromJson(json);

      expect(userModel.name, 'John Doe');
      expect(userModel.image, 'https://example.com/image.jpg');
      expect(userModel.email, 'john@example.com');
      expect(userModel.phone, '1234567890');
      expect(userModel.token, 'abc123');
      expect(userModel.id, 1);
    });
  });
}

