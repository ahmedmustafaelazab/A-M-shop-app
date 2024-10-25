import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/Screens/favorites/favorites_screen.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context,state)
        {

        },
        builder: (context,state){
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              currentIndex: BlocProvider.of<LayoutCubit>(context).bottomNavIndex,
              onTap: (currentIndex) {
                if (currentIndex == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                  );
                } else {
                  cubit.changeBottomNavIndex(currentIndex: currentIndex);
                }
              },
              items:
              const
              [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
                BottomNavigationBarItem(icon: SizedBox(), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
                

              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
              },
              child: const Icon(Icons.shopping_cart),
              backgroundColor: mainColor,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: cubit.layoutScreens[cubit.bottomNavIndex],
          );
        }
    );
  }
}
