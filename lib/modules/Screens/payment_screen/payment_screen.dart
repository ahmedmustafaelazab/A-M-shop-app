import 'package:flutter/material.dart';
import 'package:shop_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/Screens/payment_screen/add_creditcard.dart';
import 'package:shop_app/shared/style/colors.dart';

class PaymentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedMonth;
    String? selectedYear;

    return Container(
  color: Colors.white,
  child: Scaffold(
    appBar: AppBar(
      backgroundColor: mainColor,
      title: Text(
        "Add Payment 💳",
        style: TextStyle(color: thirdColor),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: thirdColor),
        onPressed: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => CartScreen()));
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
                  TextFormField(
                    decoration: InputDecoration(
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
                      // Check if the name contains any digits
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return 'Please enter only characters for the name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
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
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
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
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
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
                  SizedBox(height: 50),
                  
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(mainColor)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddCreditcard()));
                        // handle form submission if needed
                      }
                    },
                    child: Text("Add now", style: TextStyle(color: thirdColor,fontWeight: FontWeight.bold,fontSize: 20)),
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