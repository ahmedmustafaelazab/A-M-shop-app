import 'package:shop_app/modules/Screens/auth_screens/login_screen.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/alert_dialog.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_states.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: mainColor,
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is RegisterLoadingState) {
              showAlertDialog(
                context: context,
                backgroundColor: Colors.white,
                content: Row(
                  children: [
                    const CircularProgressIndicator(color: mainColor),
                    SizedBox(width: 12.5.w),
                    const Text("Please wait...",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              );
            } else if (state is FailedToRegisterState) {
              Navigator.pop(context); // Close loading dialog
              showAlertDialog(
                context: context,
                backgroundColor: Colors.red,
                content: Text(state.message, textDirection: TextDirection.rtl),
              );
            } else if (state is RegisterSuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 20.h),
                            decoration: BoxDecoration(
                              color: thirdColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(160.r),
                                topRight: Radius.circular(10.r),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  textFormItem(
                                      hintTitle: "User Name",
                                      controller: nameController,
                                      icon: Icons.person),
                                  SizedBox(height: 15.h),
                                  textFormItem(
                                      hintTitle: "Email",
                                      controller: emailController,
                                      icon: Icons.email),
                                  SizedBox(height: 15.h),
                                  textFormItem(
                                      hintTitle: "Phone",
                                      controller: phoneController,
                                      icon: Icons.phone),
                                  SizedBox(height: 15.h),
                                  textFormItem(
                                    hintTitle: "Password",
                                    controller: passwordController,
                                    icon: Icons.lock,
                                    isPassword: true,
                                    isPasswordVisible: _isPasswordVisible,
                                  ),
                                  SizedBox(height: 20.h),
                                  MaterialButton(
                                    minWidth: double.infinity,
                                    height: 40.h,
                                    color: mainColor,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .register(
                                          email: emailController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: Text(
                                      state is RegisterLoadingState
                                          ? "Loading..."
                                          : "Register",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.5.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account? ',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      SizedBox(width: 4.w),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                          );
                                        },
                                        child: const Text('Login',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget textFormItem({
    required String hintTitle,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    ValueNotifier<bool>? isPasswordVisible,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPasswordVisible ?? ValueNotifier<bool>(false),
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          obscureText: isPassword && !value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      value ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      isPasswordVisible!.value = !value;
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: mainColor),
            ),
            hintText: hintTitle,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          validator: (input) {
            if (controller.text.isNotEmpty) {
              return null;
            } else {
              return "$hintTitle must not be empty!";
            }
          },
          autofocus: true,
        );
      },
    );
  }
}
