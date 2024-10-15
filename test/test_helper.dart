import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';

void main() {
  group('AuthCubit', () {
    late AuthCubit authCubit;

    setUp(() {
      authCubit = AuthCubit();
    });

    test('The initial state is correct', () {
      expect(authCubit.state, AuthInitial());
    });

    test('The state changes when login is successful', () {
      // Simulate a successful login
      authCubit.login(email: 'test@example.com', password: 'password');
      expect(authCubit.state, AuthLoggedIn());
    });

    test('The state changes when login fails', () {
      // Simulate a failed login
      authCubit.login(email: 'wrong', password: 'wrong');
      expect(authCubit.state, AuthLoginFailed());
    });
  });
}