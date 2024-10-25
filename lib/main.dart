import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:shop_app/modules/Screens/boarder_screen/boarder_screen.dart';
import 'package:shop_app/shared/bloc_observer/bloc_observer.dart';
import 'package:shop_app/shared/constnts/constants.dart';
import 'package:shop_app/shared/network/local_network.dart';
import 'package:shop_app/shared/style/theme_cubit.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  token = await CacheNetwork.getCacheData(key: 'token');
  password = await CacheNetwork.getCacheData(key: 'password');
  debugPrint("token is : $token");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(
              create: (context) => LayoutCubit()
                ..getCart()
                ..getFavorites()
                ..getBanners()
                ..getCategories()
                ..getProducts(),
            ),
            BlocProvider(create: (context) => ThemeCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final themeCubit = context.read<ThemeCubit>();
              return MaterialApp(
                theme: themeCubit.lightTheme.copyWith(
                  textTheme: themeCubit.lightTheme.textTheme.apply(
                    fontFamily: 'CourierPrime',
                  ),
                  appBarTheme: const AppBarTheme(
                    titleTextStyle: TextStyle(
                      fontFamily:
                          'CourierPrime', 
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily:
                            'CourierPrime', 
                      ),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily:
                            'CourierPrime', 
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily:
                            'CourierPrime', 
                      ),
                    ),
                  ),
                ),
                darkTheme: themeCubit.darkTheme.copyWith(
                  textTheme: themeCubit.darkTheme.textTheme.apply(
                    fontFamily: 'CourierPrime',
                  ),
                  appBarTheme: const AppBarTheme(
                    titleTextStyle: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily: 'CourierPrime',
                      ),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily: 'CourierPrime',
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontFamily: 'CourierPrime',
                      ),
                    ),
                  ),
                ),
                themeMode:
                    themeCubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: token != null
                    ? const LayoutScreen()
                    : const BoarderScreen(),
              );
            },
          ),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
