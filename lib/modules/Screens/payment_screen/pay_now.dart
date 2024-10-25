import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/shared/style/colors.dart';

class PayNow extends StatelessWidget {
  const PayNow({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return Theme(
      // Create a new ThemeData based on the current theme
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Cairo', // Replace with your desired font
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset("images/payment1.webp"),
              const Spacer(flex: 2),
              Text(
                "${cubit.cartData.map((e) => e.price).reduce((value, element) => value + element)} \$",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold,fontFamily: 'CourierPrime'),
              ),
              Text(
                "will be deducted from your account",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold ,fontFamily: 'CourierPrime'),
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: AlertDialog(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                  "images/payment2.webp"),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Payment Done Successfully \n Your Order  #785674",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyApp())); // Close the dialog
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      mainColor, 
                                ),
                                child: const Text(
                                  "Home",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        thirdColor, 
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      mainColor, 
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: thirdColor, 
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
