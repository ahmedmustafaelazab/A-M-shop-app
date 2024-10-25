import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/payment_screen/add_your_info.dart';
import '../../../shared/style/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart 🛒"),
            elevation: 0,
            backgroundColor: isDarkMode ? Colors.black : mainColor,
            foregroundColor: thirdColor,
          ),
          body: cubit.cartData.isEmpty
              ? const Center(
                  child: Text("Loading....⏳"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.5, vertical: 10),
                        child: ListView.builder(
                          itemCount: cubit.cartData.length,
                          itemBuilder: (context, index) {
                            return _cartItem(
                              context: context,
                              url: cubit.cartData[index].image,
                              title: cubit.cartData[index].name,
                              id: cubit.cartData[index].id!,
                              cubit: cubit,
                              price: cubit.cartData[index].price.toInt(),
                              oldPrice: cubit.cartData[index].oldPrice.toInt(),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.5, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Price:💵"),
                          Text(
                              "${cubit.cartData.map((e) => e.price).reduce((value, element) => value + element)} \$"),
                        ],
                      ),
                    ),
                    MaterialButton(
                      color: mainColor,
                      height: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.5)),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddYourInfo()));
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                            fontFamily: 'CourierPrime'), // Added fontFamily
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  // ...
}

Widget _cartItem(
    {required BuildContext context,
    required int price,
    required int oldPrice,
    required String url,
    required String title,
    required String id,
    required LayoutCubit cubit}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : thirdColor,
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
            borderRadius:
                BorderRadius.circular(10), 
          ),
          child: Image.network(
            url,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "$price \$",
                      style: const TextStyle(fontSize: 13),
                    )),
                const SizedBox(
                  width: 5,
                ),
                if (oldPrice != 0 && oldPrice != price)
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("$oldPrice \$",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)))
              ],
            ),
            MaterialButton(
              color: mainColor,
              height: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.5)),
              textColor: Colors.white,
              onPressed: () {
                cubit.addOrRemoveFromCart(productID: id);
              },
              child: const Text(
                "Remove",
                style:
                    TextStyle(fontFamily: 'CourierPrime'), // Added fontFamily
              ),
            )
          ],
        ))
      ],
    ),
  );
}
