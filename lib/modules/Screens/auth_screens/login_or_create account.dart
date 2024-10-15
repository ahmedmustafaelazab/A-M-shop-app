import 'package:flutter/material.dart';
import 'package:shop_app/modules/Screens/auth_screens/login_screen.dart';
import 'package:shop_app/modules/Screens/auth_screens/register_screen.dart';
import 'package:shop_app/shared/style/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      color: mainColor, // Set the button color
      textColor: Colors.white, // Set the text color
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 150.0), // Set padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Set border radius
      ),
      child: Text(text),
    );
  }
}

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  "https://i.postimg.cc/pTwFBS3N/shop-app-with-earthy-green-color-0x-FF819f7f-1-removebg-preview.png",
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: "login",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                text: "Sign Up",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}