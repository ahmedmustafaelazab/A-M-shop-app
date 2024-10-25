import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Screens/auth_screens/login_screen.dart';
import '../../../models/category_model.dart';
import '../../../shared/style/colors.dart';
import 'package:shop_app/modules/Screens/product_details/product_details.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          drawer: SafeArea(
            child: ListTileTheme(
              textColor: isDarkMode ? Colors.white : Colors.black,
              iconColor: Colors.grey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Image.asset(
                      'images/cart_drawer 1.png',
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final isDarkMode =
                              Theme.of(context).brightness == Brightness.dark;
                          return AlertDialog(
                            backgroundColor:
                                isDarkMode ? Colors.black : Colors.white,
                            title: Text(
                              "About Us",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            content: Text(
                              "A&M Shop is your one-stop destination for a wide range of products,We offer everything from electronics to fashion, home essentials, and much more, all at affordable prices,Our goal is to provide a seamless and enjoyable shopping experience for our customers.",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Close",
                                    style: TextStyle(
                                        color: mainColor, fontSize: 20)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.info),
                    title: const Text('About Us'),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final isDarkMode =
                              Theme.of(context).brightness == Brightness.dark;
                          return AlertDialog(
                            backgroundColor:
                                isDarkMode ? Colors.black : Colors.white,
                            title: Text(
                              "Contact Us 📞",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            content: Text(
                              "You can contact us \n A & M @gmail.com \n 123-456-7890",
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Close",
                                    style: TextStyle(
                                        color: mainColor, fontSize: 20)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.contact_phone),
                    title: const Text('Contact Us'),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final isDarkMode =
                              Theme.of(context).brightness == Brightness.dark;
                          return AlertDialog(
                            backgroundColor:
                                isDarkMode ? Colors.black : Colors.white,
                            title: Text(
                              "FAQ",
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Text(
                                "1. Enhanced Search Functionality: We use advanced algorithms to increase search result accuracy. 🔍\n\n"
                                "2. Favorites List: You can add your favorite products for easy access later on. ❤\n\n"
                                "3. Dark Mode Feature: Our app includes an option to activate dark mode in settings. This improves user experience and makes the app more comfortable for the eyes, especially at night. 🌙",
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Close",
                                  style:
                                      TextStyle(color: mainColor, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.question_answer),
                    title: const Text('FAQ'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("A & M Shop 🛒"),
              elevation: 0,
              backgroundColor: isDarkMode ? Colors.black : mainColor,
              foregroundColor: thirdColor,
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12.5),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  TextFormField(
                    onChanged: (input) {
                      cubit.filterProducts(input: input);
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: mainColor, width: 2.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: secondColor, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.clear),
                        )),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  cubit.bannersData.isEmpty
                      ? _loadingWidget()
                      : SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.bannersData.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _bannerItem(
                                    url: cubit.bannersData[index].image!);
                              })),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: mainColor),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          "",
                          style: TextStyle(
                              color: secondColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  cubit.productsData.isEmpty
                      ? _loadingWidget()
                      : GridView.builder(
                          itemCount: cubit.productsFiltered.isEmpty
                              ? cubit.productsData.length
                              : cubit.productsFiltered.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductDetails(
                                      model: cubit.productsData[index]);
                                }));
                              },
                              child: _productItem(
                                  cubit: cubit,
                                  productModel: cubit.productsFiltered.isEmpty
                                      ? cubit.productsData[index]
                                      : cubit.productsFiltered[index]),
                            );
                          })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  // This widget will be shown during during there is no Data
  Widget _loadingWidget() {
    return const Center(child: CupertinoActivityIndicator());
  }

  // Banner Widget
  Widget _bannerItem({required String url}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.only(right: 15),
      child: Image.network(
        url,
        fit: BoxFit.fill,
        width: 220,
      ),
    );
  }

  // Category Widget
  Widget _categoryItem({required CategoryModel categoryModel}) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {
          // Here Will open Categories Screen
        },
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(categoryModel.image!),
        ),
      ),
    );
  }

  // Product Widget
  Widget _productItem(
      {required LayoutCubit cubit, required ProductModel productModel}) {
    double discount = 0.1; // 10% discount
    double discountedPrice = productModel.price * (1 - discount);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: mainColor,
          width: 2.0, 
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20), 
              child: Image.network(
                productModel.image,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            productModel.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${productModel.price} \$",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        "${discountedPrice.toStringAsFixed(2)} \$",
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.addOrRemoveToOrFromFavorites(
                      productID: productModel.id!);
                },
                child: Icon(Icons.favorite,
                    size: 20,
                    color: cubit.favoritesStatus.contains(productModel.id!)
                        ? Colors.red
                        : Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
