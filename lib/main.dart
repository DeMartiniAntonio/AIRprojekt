import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/GeneratedRegistrationWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedloginwidget/GeneratedLoginWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedqr_code_scanwidget/GeneratedQR_code_scanWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/GeneratedPaymentWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedreset_passwordwidget/GeneratedReset_passwordWidget.dart';

void main() {
  Stripe.publishableKey = "pk_test_51NOKz4GAMBmTAYlAYfQeJVo4QpzIFjtV22SpkZNjqbPOdCNR4T7uCP3Ld6EP5Z3XVI75DlTet4UalJEFWs5qIBwK00Rnk9Lo8Y";
  runApp(VendingMachineApp());
}

class VendingMachineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedPaymentWidget',
      routes: {
        '/GeneratedRegistrationWidget': (context) =>
            GeneratedRegistrationWidget(),

        '/GeneratedLoginWidget': (context) => GeneratedLoginWidget(),
        '/GeneratedQR_code_scanWidget': (context) =>
            GeneratedQR_code_scanWidget(),
        '/GeneratedPaymentWidget': (context) => GeneratedPaymentWidget(),
        '/GeneratedReset_passwordWidget': (context) =>  GeneratedReset_passwordWidget(),

      },
    );
  }
}
