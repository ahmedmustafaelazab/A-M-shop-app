import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/layout_states.dart';
import 'package:shop_app/shared/constnts/constants.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isNewPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    currentPasswordController.text =
        password!; // Assuming password is defined somewhere
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    
    final brightness = Theme.of(context).brightness;

    
    final isDarkMode = brightness == Brightness.dark;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Change Password",
              style:
                  TextStyle(color: thirdColor), 
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: thirdColor), 
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: isDarkMode
                ? Colors.black
                : mainColor, // 
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: isDarkMode
              ? darkBackgroundColor
              : lightBackgroundColor, 
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: currentPasswordController,
                    validator: (input) {
                      if (currentPasswordController.text == password) {
                        return null;
                      } else {
                        return "Check your password, try again!";
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Current Password",
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: _isNewPasswordObscured,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "New Password",
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordObscured = !_isNewPasswordObscured;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.changePassword(
                            newPassword: newPasswordController.text);
                      }
                    },
                    color: mainColor,
                    textColor: Colors.white,
                    child: Text(state is ChangePasswordLoadingState
                        ? "Loading....."
                        : "Submit"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) Navigator.pop(context);
      },
    );
  }
}
