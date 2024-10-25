import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/shared/style/theme_cubit.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    test('initial state is LightThemeState', () {
      expect(themeCubit.state, isA<LightThemeState>());
    });

    test('toggleTheme changes state', () {
      themeCubit.toggleTheme();
      expect(themeCubit.state, isA<DarkThemeState>());
      themeCubit.toggleTheme();
      expect(themeCubit.state, isA<LightThemeState>());
    });

    test('isDarkMode returns correct value', () {
      expect(themeCubit.isDarkMode, false);
      themeCubit.toggleTheme();
      expect(themeCubit.isDarkMode, true);
    });
  });
}
