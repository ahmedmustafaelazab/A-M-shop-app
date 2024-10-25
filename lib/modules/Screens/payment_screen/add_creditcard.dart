import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
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
            const Spacer(flex: 2),
            Text(
              "${cubit.cartData.map((e) => e.price).reduce((value, element) => value + element)} \$",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "will be deducted from your account",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                              "https://i.postimg.cc/Y05yJcnF/yy.webp"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Payment Done Successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      actions: [
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  mainColor, // Set the background color to mainColor
                            ),
                            child: const Text(
                              "Home",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    thirdColor, // Set the text color to thirdColor
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    mainColor, // Set the background color to mainColor
              ),
              child: const Text(
                "Pay Now",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: thirdColor, // Set the text color to thirdColor
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
