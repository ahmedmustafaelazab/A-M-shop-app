import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/layout_cubit/layout_cubit.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UpdateUserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    if (cubit.userModel != null) {
      nameController.text = cubit.userModel!.name ?? '';
      phoneController.text = cubit.userModel!.phone ?? '';
    } else {
      nameController.text = '';
      phoneController.text = '';
    }

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Update Data",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: isDarkMode ? Colors.black : mainColor,
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (input) {
                      if (input!.isNotEmpty) {
                        return null;
                      } else {
                        return "Name must not be empty";
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "User  Name",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "Phone number must not be empty";
                      } else if (input.length < 10) {
                        return "Phone number must be at least 10 digits";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (nameController.text != cubit.userModel?.name ||
                            phoneController.text != cubit.userModel?.phone) {
                          cubit.updateUserData(
                              phone: phoneController.text,
                              name: nameController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Container(
                            child: const Text("There is no change on Data!"),
                          )));
                        }
                      }
                    },
                    color: mainColor,
                    textColor: Colors.white,
                    child: Text(state is UpdateUserDataLoadingState
                        ? "Loading....."
                        : "Update"),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is UpdateUserDataSuccessState) Navigator.pop(context);
      },
    );
  }
}
