import 'package:shop_app/modules/Screens/auth_screens/login_screen.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showAlertDialog(
              context: context,
              backgroundColor: Colors.white,
              content: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Row(
                  children: [
                    const CupertinoActivityIndicator(color: mainColor),
                    SizedBox(
                      width: 12.5.w,
                    ),
                    const Text(
                      "wait",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ));
        } else if (state is FailedToRegisterState) {
          showAlertDialog(
              context: context,
              backgroundColor: Colors.red,
              content: Text(
                state.message,
                textDirection: TextDirection.rtl,
              ));
        } else if (state is RegisterSuccessState) {
          Navigator.pop(context); // عشان يخرج من alertDialog
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Text(""),
          ),
          body: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 22.5.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        textFormItem(
                            hintTitle: "User Name", controller: nameController,icon: Icons.person,),
                        SizedBox(
                          height: 20.h,
                        ),
                        textFormItem(
                            hintTitle: "Email", controller: emailController, icon: Icons.email,),
                        SizedBox(
                          height: 20.h,
                        ),
                        textFormItem(
                            hintTitle: "Phone", controller: phoneController,icon: Icons.phone,),
                        SizedBox(
                          height: 20.h,
                        ),
                        textFormItem(
                            hintTitle: "Password",
                            controller: passwordController,icon: Icons.lock,),
                        SizedBox(
                          height: 20.h,
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          elevation: 0,
                          height: 40.h,
                          color: mainColor,
                          onPressed: () {
                            if (formKey.currentState!.validate() == true) {
                              BlocProvider.of<AuthCubit>(context).register(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                state is RegisterLoadingState
                                    ? "Loading..."
                                    : "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5.sp,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? ',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(
                              width: 4.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: const Text('login in',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  // TextFormField Item as I use it more than one time
 // TextFormField Item as I use it more than one time
Widget textFormItem(
    {required String hintTitle,
    required TextEditingController controller,
    required IconData icon}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      hintText: hintTitle,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: mainColor),
      ),
    ),
    validator: (input) {
      if (controller.text.isNotEmpty) {
        return null;
      } else {
        return "$hintTitle must not be empty!";
      }
    },
  );
} }