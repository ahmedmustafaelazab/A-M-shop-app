import 'package:flutter/material.dart';
import 'package:shop_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/Screens/payment_screen/pay_now.dart';
import 'package:shop_app/shared/style/colors.dart';

class AddYourInfo extends StatefulWidget {
  const AddYourInfo({Key? key}) : super(key: key);

  @override
  _AddYourInfoState createState() => _AddYourInfoState();
}

class _AddYourInfoState extends State<AddYourInfo> {
  final _formKey = GlobalKey<FormState>();
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    String? selectedMonth;
    String? selectedYear;

    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Your Info", style: TextStyle(color: thirdColor)),
          elevation: 0,
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : mainColor,
          foregroundColor: thirdColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: thirdColor),
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Check if the phone number is exactly 10 digits
                      if (value.length != 11) {
                        return 'Phone number should be 11 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(150 ~/ 10, (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 2,
                      ),
                    )),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Name on Card",
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name on card';
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return 'Please enter only characters for the name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Card Number",
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your card number';
                      }
                      if (value.length != 16) {
                        return 'Card number should be 16 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Month",
                            labelStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                          ),
                          value: selectedMonth,
                          items: List.generate(12, (index) {
                            String month = (index + 1).toString().padLeft(2, '0');
                            return DropdownMenuItem(
                              child: Text(month),
                              value: month,
                            );
                          }),
                          onChanged: (value) {
                            selectedMonth = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Year",
                            labelStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                          ),
                          value: selectedYear,
                          items: List.generate(20, (index) {
                            String year = (DateTime.now().year + index).toString();
                            return DropdownMenuItem(
                              child: Text(year),
                              value: year,
                            );
                          }),
                          onChanged: (value) {
                            selectedYear = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "CVC",
                      labelStyle: TextStyle(color: mainColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your CVC';
                      }
                      if (value.length < 3 || value.length > 4) {
                        return 'CVC should be 3 or 4 digits';
                      }
                      return null;
                    },
                  ),
                  
                  

                  const SizedBox(height: 50),
                  
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(mainColor)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PayNow()));
                        // handle form submission if needed
                      }
                    },
                    child: const Text("Continue", style: TextStyle(color: thirdColor,fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
