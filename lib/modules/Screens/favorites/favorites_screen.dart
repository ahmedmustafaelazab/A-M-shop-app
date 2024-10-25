import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Favorites", style: TextStyle(color: thirdColor)),
            elevation: 0,
            backgroundColor: isDarkMode ? Colors.black : mainColor,
            foregroundColor: thirdColor,
          ),
          body: cubit.favoritesData.isEmpty
              ? const Center(child: Text("Loading....⏳"))
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.5, vertical: 10),
                  child: ListView.builder(
                    itemCount: cubit.favoritesData.length,
                    itemBuilder: (context, index) {
                      return _favoriteItem(
                        context: context,
                        url: cubit.favoritesData[index].image,
                        title: cubit.favoritesData[index].name,
                        id: cubit.favoritesData[index].id!,
                        cubit: cubit,
                        price: cubit.favoritesData[index].price.toInt(),
                        oldPrice: cubit.favoritesData[index].oldPrice.toInt(),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  Widget _favoriteItem({
    required int price,
    required int oldPrice,
    required String url,
    required String title,
    required String id,
    required LayoutCubit cubit,
    required BuildContext context,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : thirdColor,
        border: Border.all(
          color: mainColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: mainColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(url, fit: BoxFit.fill),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "$price \$",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (oldPrice != 0 && oldPrice != price)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$oldPrice \$",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
                MaterialButton(
                  color: mainColor,
                  height: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    cubit.addOrRemoveToOrFromFavorites(productID: id);
                  },
                  child: const Text(
                    "Remove",
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
