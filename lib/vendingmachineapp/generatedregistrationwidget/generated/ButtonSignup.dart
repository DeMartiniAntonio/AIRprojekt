import 'dart:ffi';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter/material.dart';
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxConfirmPassword.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxFirstName.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxLastName.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxEmail.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxPasswordRegistration.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/generated/TextBoxConfirmPassword.dart';

var addUserEndpoint = 'https://air2218.mobilisis.hr/api/api/VendingMachine/AddUser';
var uniqueEmail='https://air2218.mobilisis.hr/api/api/VendingMachine/UniqueEmail';
var emailExist;

<<<<<<< HEAD
testEmail(String email) async {
    final response =await http.get(Uri.parse('$uniqueEmail/?email=$email'));
=======
Future<bool> testEmail(String email) async {
    final response =await http.get(Uri.parse('$uniqueEmail/$email'));
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
}

/*Future<bool> testPassword(String password) async {
  final response =await http.get(Uri.parse('$uniquePassword/$password'));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}*/

Future<http.Response> registerUser(String firstName, String lastName, String email, String password, int roleId) async {
  final body = jsonEncode({
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "role_id": roleId
  });

  final response = await http.post(
    Uri.parse(addUserEndpoint),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  print(response.statusCode);
  return response;

}

class ButtonSignup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
<<<<<<< HEAD
          onTap: () async {
=======
          onTap: () {
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
            var firstName = TextBoxFirstName.firstNameRegistration.text;
            var lastName = TextBoxLastName.lastNameRegistration.text;
            var email = TextBoxEmail.emailRegistration.text;
            var password = TextBoxPasswordRegistration.passwordRegistration.text;
<<<<<<< HEAD
            var confirmPassword =TextBoxConfirmPassword.confirmPassword.text;
            int roleId = 2;

            emailExist= await testEmail(email);
=======
            var confirmPassword = TextBoxConfirmPassword.confirmPassword.text;
            int roleId = 2;

>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110

            var errorTest = dataTesting(firstName,lastName,email,password,confirmPassword);

            if(errorTest=="OK"){
              //registerUser(firstName, lastName, email, password, roleId);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(

                  title: Text('You are registered'),
                  actions: [
                    TextButton(
                      child: Text('Back to Sign Up'),
                      onPressed: () => Navigator.pushNamed(context, '/GeneratedLoginWidget'),
                    ),
                  ],
                ),
              );
            }
            else{
              showDialog(
                context: context,
                builder: (context) => AlertDialog(

                  title: Text(errorTest),
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
        width: 340.0,
        height: 62.53499984741211,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.51735305786133),
        boxShadow: kIsWeb
        ? []
            : [
        BoxShadow(
        color: Color.fromARGB(63, 0, 0, 0),
        offset: Offset(4.246203422546387, 4.246203422546387),
        blurRadius: 4.246203422546387,
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
          height: 62.53499984741211,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36.51735305786133),
            child: Container(
              color: Color.fromARGB(255, 29, 53, 87),
                ),
              ),
            ),
            Positioned(
              left: 105.0,
              top: null,
              right: 104.0,
              bottom: null,
              width: null,
              height:
              36.0,
                child: TransformHelper.translate(
                    x: 0.00, y: 0.73, z: 0,
                child: Text(
                    '''Sign up''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2102273127828058,
                      fontSize: 30.572668075561523,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),

            /* letterSpacing: 0.0, */
          ),
        ),
                ),
      ),
      ]),
      ),
    );
  }

<<<<<<< HEAD
    dataTesting(String firstName, String lastName, String email, String password, String confirmPassword)  {
=======
    dataTesting(String firstName, String lastName, String email, String password, String confirmPassword) {
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty ||
            password.isEmpty || confirmPassword.isEmpty) {
          return "Some fields are empty";
        }

        if (email.endsWith("@gmail.com")) {
<<<<<<< HEAD

          print(emailExist);
=======
          emailExist = testEmail(email);
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
        }
        else {
          return "Email is not valid!";
        }

<<<<<<< HEAD
        if (emailExist == false) {
          return "Email already exists!";
        }

        if(password.length<8){
          return "Password is too short!";
=======
        if (emailExist == true) {
          return "Email already exist!";
>>>>>>> 5338af3d0c2c59bd13452f369e7ab3c9002e3110
        }

        if (password == confirmPassword) {
          //passwordExist=testpassword(password);
        }
        else {
          return "Passwords do not match!";
        }

        /*if(passwordExist==true){
        return "Password already exist!";
      }*/

      return "OK";

    }
}





