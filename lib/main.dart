import 'package:flutter/material.dart';
import 'package:flutterapp/vendingmachineapp/generatedregistrationwidget/GeneratedRegistrationWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedloginwidget/GeneratedLoginWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedqr_code_scanwidget/GeneratedQR_code_scanWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/GeneratedPaymentWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedreset_passwordwidget/GeneratedReset_passwordWidget.dart';

void main() {
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
      initialRoute: '/GeneratedLoginWidget',
      routes: {
        '/GeneratedRegistrationWidget': (context) =>
            GeneratedRegistrationWidget(),
        '/GeneratedLoginWidget': (context) => GeneratedLoginWidget(),
        '/GeneratedQR_code_scanWidget': (context) =>
            GeneratedQR_code_scanWidget(),
        '/GeneratedPaymentWidget': (context) => GeneratedPaymentWidget(),
        '/GeneratedReset_passwordWidget': (context) =>
            GeneratedReset_passwordWidget(),
      },
    );
  }
}
