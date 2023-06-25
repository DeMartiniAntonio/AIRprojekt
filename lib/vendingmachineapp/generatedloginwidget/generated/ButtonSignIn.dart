import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/vendingmachineapp/generatedloginwidget/generated/TextboxUsernameLogin.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/vendingmachineapp/generatedloginwidget/generated/TextboxPasswordLogin.dart';
import 'package:flutterapp/vendingmachineapp/User.dart';

var check='https://air2218.mobilisis.hr/api/api/VendingMachine/LoginRequest';


Future<bool> existnigUser(String email, String password ) async {
  final response =await http.get(Uri.parse('$check?email=$email&password=$password'));
  if (response.statusCode == 200) {

    var jsonData = jsonDecode(response.body);

    User loggedIn=User(
      user_ID: jsonData['user_ID'],
      first_name: jsonData['first_name'],
      last_name: jsonData['last_name'],
      email: jsonData['email'],
    );

     User.saveLoggedInUser(loggedIn);

    return true;

  } else {
    return false;
  }
}

class ButtonSignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () async {
            var username= TextboxUsernameLogin.signUpUserNameController.text;
            var password= TextboxPasswordLogin.signUpPasswordController.text;

            bool isUserExisting = await existnigUser(username, password);
            if (isUserExisting) {
              TextboxPasswordLogin.signUpPasswordController.clear();
              TextboxUsernameLogin.signUpUserNameController.clear();
              Navigator.pushNamed(context, '/GeneratedQR_code_scanWidget');
            }
            else{
              showDialog(
                context: context,
                builder: (context) => AlertDialog(

                  title: Text("Email or password is invalid!"),
                  actions: [
                    TextButton(
                        child: Text('Back'),
                        onPressed: () {

                          Navigator.pop(context);
                        }
                    ),
                  ],
                ),
              );
            }
          },

      child: Container(
        width: 312.0,
        height: 67.1500015258789,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.54999923706055),
          boxShadow: kIsWeb
              ? []
              : [
            BoxShadow(
              color: Color.fromARGB(63, 0, 0, 0),
              offset: Offset(4.25, 4.25),
              blurRadius: 4.25,
            )
          ],
        ),
        child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0.0,
                top: null,
                right: 0.0,
                bottom: null,
                width: null,
                height: 67.1500015258789,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36.54999923706055),
                  child: Container(
                    color: Color.fromARGB(255, 29, 53, 87),
                  ),
                ),
              ),
              Positioned(
                left: 94.0,
                top: null,
                right: 92.0,
                bottom: null,
                width: null,
                height: 38.0,
                child: TransformHelper.translate(
                    x: 0.00, y: 1.42, z: 0, child: Text(
                  '''Sign In''',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.2102272780396295,
                    fontSize: 30.600000381469727,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 255, 255, 255),

                    /* letterSpacing: 0.0, */
                  ),
                ),
                ),
              )
            ]),
      ),
    );
  }
}
