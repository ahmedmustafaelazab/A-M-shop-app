import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/style/colors.dart';

abstract class ThemeState {}

class LightThemeState extends ThemeState {}

class DarkThemeState extends ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeCubit extends Cubit<ThemeState> {
  bool isDarkMode = false;

  ThemeCubit() : super(LightThemeState());

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    print('Theme toggled. isDarkMode: $isDarkMode');
    emit(isDarkMode ? DarkThemeState() : LightThemeState());
  }

  ThemeData get lightTheme => ThemeData(
        primaryColor: lightPrimaryColor,
        colorScheme: const ColorScheme.light(
          primary: lightPrimaryColor,
          secondary: lightAccentColor,
          surface: lightSurfaceColor,
          error: errorColor,
        ),
        scaffoldBackgroundColor: lightBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: lightPrimaryColor,
          foregroundColor: lightTextColor,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: lightTextColor),
          bodyMedium: TextStyle(color: lightTextColor),
          displayLarge: TextStyle(color: lightTextColor),
        ),
        iconTheme: const IconThemeData(color: lightTextColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: lightSurfaceColor,
          unselectedItemColor: lightTextColor,
        ),
        extensions: [
          CustomColors(
            productTextColor: productTextColor,
          ),
        ],
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: darkPrimaryColor,
        colorScheme: const ColorScheme.dark(
          primary: darkPrimaryColor,
          surface: darkSurfaceColor,
          error: errorColor,
        ),
        scaffoldBackgroundColor: darkBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: thirdColor,
          elevation: 0,
          iconTheme: IconThemeData(color: thirdColor),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: darkTextColor),
          bodyMedium: TextStyle(color: darkTextColor),
        ),
        iconTheme: const IconThemeData(color: darkTextColor),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkSurfaceColor,
          selectedItemColor: darkPrimaryColor,
          unselectedItemColor: darkTextColor,
        ),
        extensions: [
          CustomColors(
            productTextColor: darkProductTextColor,
          ),
        ],
      );
}

class CustomColors extends ThemeExtension<CustomColors> {
  final Color productTextColor;

  CustomColors({required this.productTextColor});

  @override
  ThemeExtension<CustomColors> copyWith({Color? productTextColor}) {
    return CustomColors(
      productTextColor: productTextColor ?? this.productTextColor,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
      ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      productTextColor:
          Color.lerp(productTextColor, other.productTextColor, t)!,
    );
  }
}
