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
    return SizedBox(
      width: double.infinity, 
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(text),
      ),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const Spacer(flex: 2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "images/boarder1.png",
                      width: constraints.maxWidth * 0.8, 
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    text: "Login",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03), 
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
              );
            },
          ),
        ),
      ),
    );
  }
}
