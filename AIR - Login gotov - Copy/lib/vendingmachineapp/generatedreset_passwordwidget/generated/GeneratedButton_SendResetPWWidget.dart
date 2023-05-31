import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/vendingmachineapp/generatedreset_passwordwidget/generated/GeneratedEnterEmailWidget.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

var uniqueEmail='https://air2218.mobilisis.hr/api/api/VendingMachine/UniqueEmail';

testEmail(String email) async {
  final response =await http.get(Uri.parse('$uniqueEmail/?email=$email'));
  if (response.statusCode == 200) {
    return false;
  } else {
    return true;
  }
}

Future<void> sendVerificationEmail(String email, String verificationCode) async {
  final smtpServer = gmail('projektair2218@gmail.com', 'projektprojekt22');

  final message = Message()
    ..from = Address('projektair2218@gmail.com', 'air 2218')
    ..recipients.add(email)
    ..subject = 'Password Reset Verification Code'
    ..text = 'Your verification code is: $verificationCode';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } catch (e) {
    print('Error occurred while sending email: $e');
  }
}

class GeneratedButton_SendResetPWWidget extends StatelessWidget {

  String email = GeneratedEnterEmailWidget.email.text;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () async {

          //bool isUserExisting = await testEmail(GeneratedEnterEmailWidget.email.text);
          bool isUserExisting=true;

          if (isUserExisting) {
            String verificationCode = generateVerificationCode();
            await sendVerificationEmail(email, verificationCode);

          }
          else{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(

                title: Text("Invalid email!"),
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

          child:Container(
            width: 312.0,
            height: 62.04999923706055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.54999923706055),
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
                    height: 62.04999923706055,
                    child: Container(
                      width: 312.0,
                      height: 62.04999923706055,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36.54999923706055),
                        child: Container(
                          color: Color.fromARGB(255, 29, 53, 87),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 118.0,
                    top: null,
                    right: 107.0,
                    bottom: null,
                    width: null,
                    height: 42.0,
                    child: TransformHelper.translate(
                        x: 0.00, y: 2.98, z: 0, child: Text(
                      '''Send''',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: 1.2102272780396295,
                        fontSize: 30.600000381469727,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),

                        /* letterSpacing: 0.0, */
                      ),
                    )),
                  )
                ]),
          ),

        );
  }

}

String generateVerificationCode() {
  return "sda";
}
