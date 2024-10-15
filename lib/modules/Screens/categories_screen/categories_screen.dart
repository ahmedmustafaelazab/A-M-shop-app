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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        elevation: 0,
        backgroundColor: thirdColor,
        foregroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12.5),
        child: cubit.categoriesData.isEmpty
            ? _loadingWidget()
            : ListView.builder(
                itemCount: cubit.categoriesData.length,
                itemBuilder: (context, index) {
                  return _categoryItem(categoryModel: cubit.categoriesData[index]);
                },
              ),
      ),
    );
  }

  Widget _loadingWidget() {
    return const Center(child: CupertinoActivityIndicator());
  }

  Widget _categoryItem({required CategoryModel categoryModel}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: mainColor, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: categoryModel.image != null
                    ? NetworkImage(categoryModel.image!)
                    : null,
              ),
            ),
           
            
          ],
        ),
      ),
    );
  }
}