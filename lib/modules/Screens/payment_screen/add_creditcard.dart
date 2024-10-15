import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/shared/style/colors.dart';

class AddCreditcard extends StatelessWidget {
  const AddCreditcard({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.network("https://i.postimg.cc/Gm9rj7FL/g10.webp"),
            const Spacer(flex: 3),
            Text(
              "The amount deducted is:",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "${cubit.cartData.map((e) => e.price).reduce((value, element) => value + element)} \$",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 3),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: const Text(
                "Back to home",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              label: const Icon(
                Icons.home_repair_service,
                size: 30,
                color: mainColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
