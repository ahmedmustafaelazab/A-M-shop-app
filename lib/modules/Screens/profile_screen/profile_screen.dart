import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/Screens/change_password_screen/change_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/favorites/favorites_screen.dart';
import '../../../layout/layout_cubit/layout_cubit.dart';
import '../../../shared/style/colors.dart';
import '../update_user_data_screen/update_user_data.dart';
import 'package:shop_app/shared/style/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return Builder(builder: (context) {
      if (cubit.userModel == null) {
        cubit.getUserData();
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile", style: TextStyle(color: thirdColor)),
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : mainColor,
          foregroundColor: thirdColor,
        ),
        body: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                bool isDarkMode = themeState is DarkThemeState;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          if (cubit.userModel != null) ...[
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              cubit.userModel!.name.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isDarkMode ? Colors.white : mainColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cubit.userModel!.email.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : mainColor,
                              ),
                            ),
                          ] else
                            const CupertinoActivityIndicator(
                              color: mainColor,
                            ),
                          const SizedBox(height: 24),
                          // Theme toggle button
                          BlocBuilder<ThemeCubit, ThemeState>(
                            builder: (context, state) {
                              bool isDarkMode = state is DarkThemeState;
                              return _buildButton(
                                icon: isDarkMode
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                                title: isDarkMode
                                    ? "Switch to Light Mode"
                                    : "Switch to Dark Mode",
                                onTap: () {
                                  context.read<ThemeCubit>().toggleTheme();
                                },
                              );
                            },
                          ),

                          // Profile options
                          _buildButton(
                            icon: Icons.lock,
                            title: "Change Password",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordScreen()));
                            },
                          ),
                          _buildButton(
                            icon: Icons.edit,
                            title: "Update Data",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateUserDataScreen()));
                            },
                          ),
                          _buildButton(
                            icon: Icons.shopping_cart,
                            title: "Orders",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CartScreen()));
                            },
                          ),
                          _buildButton(
                            icon: Icons.favorite,
                            title: "Favorite",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FavoritesScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = state is DarkThemeState;
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.black : mainColor,
              foregroundColor: thirdColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: thirdColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: thirdColor,
                      fontFamily: 'CourierPrime',
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: thirdColor),
              ],
            ),
          ),
        );
      },
    );
  }
}
