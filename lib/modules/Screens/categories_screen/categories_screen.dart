import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/style/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(
            color: isDarkMode ? Colors.white : thirdColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : mainColor,
        foregroundColor: isDarkMode ? Colors.white : thirdColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Colors.black, const Color(0xFF1A1A1A)]
                : [mainColor.withOpacity(0.8), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: cubit.categoriesData.isEmpty
              ? _loadingWidget()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: cubit.categoriesData.length,
                  itemBuilder: (context, index) {
                    String? customName =
                        index < customNames.length ? customNames[index] : null;
                    return _categoryItem(
                      categoryModel: cubit.categoriesData[index],
                      customName: customName,
                      isDarkMode: isDarkMode,
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return const Center(child: CupertinoActivityIndicator());
  }

  Widget _categoryItem({
    required CategoryModel categoryModel,
    String? customName,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Color(0xFF2C2C2C), Color(0xFF1A1A1A)]
                : [mainColor.withOpacity(0.8), mainColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'category_${categoryModel.id}',
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: categoryModel.image != null
                      ? Image.network(
                          categoryModel.image!,
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.grey),
                ),
              ),
            ),
            if (customName != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  customName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : thirdColor,
                    fontFamily: 'CourierPrime',
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

List<String> customNames = [
  "Electronics 🔌",
  "Medical 💊",
  "Sports ⚽",
  "Light 💡",
  "Shoes 👟",
  "Vegetables 🥦"
];
