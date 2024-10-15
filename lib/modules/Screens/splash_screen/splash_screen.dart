import 'package:flutter/material.dart';
import 'package:shop_app/modules/Screens/auth_screens/login_or_create%20account.dart';
import 'package:shop_app/shared/style/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome To A & M Shop" ,
      "image": "https://i.postimg.cc/pTwFBS3N/shop-app-with-earthy-green-color-0x-FF819f7f-1-removebg-preview.png"
    },
    {
      "text":
          " We Help You Buy Easily and Securely",
      "image": "https://i.postimg.cc/TYGJnMTn/ecommerce-market-01.png"
    },
    {
      "text": "let's Go Shop",
      "image": "https://i.postimg.cc/R0CQ3jxX/p4-01-1536x909.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 40 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color(0xFF819f7f)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOrSignupScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF819f7f),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text("Continue"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
        height: 10,
        ),
        const Text(
          "A & M Shop",
          style: TextStyle(
            fontSize: 32,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            widget.image!,
            fit: BoxFit.contain,
            height: 350,
            width: 350,
          ),
        ),
        const Spacer( flex: 1,),
      ],
    );
  }
}
