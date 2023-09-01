import 'dart:convert';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';


class StripePay implements PaymentInterface {


  @override
  Future<void> executePayment(BuildContext context, PaymentListener listener, String amount) async {
    Map<String, dynamic>? paymentIntent;
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stripe Payment'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Buy Now'),
                onPressed: () async {
                  await executePayment(context, listener, amount);
                },
              ),
            ],
          ),
        ),
      );
    }
    try {
      paymentIntent = await createPaymentIntent('500', 'EUR');

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent![
            'client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'Test',
          ))
          .then((value) {});

      isPaymentDone(context, listener);
    } catch (err) {
      print(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51NOKz4GAMBmTAYlA5udflpJ8TFyLoYZ1P6jZVDqIFo1tJ8QYI1mrCPNCck1Dlv8VU6yCZcEPdgoBtNfFoHel5LAT00QezbQE16',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,

      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }

  }

  Future<void> isPaymentDone(BuildContext context,PaymentListener listener ) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        listener.onSuccess(context);
        print("Payment Successfull");
      });
    } catch (e) {
      listener.onFailure(context);
      print('$e');

    }
  }

  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    throw UnimplementedError();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
  }

  @override
  // TODO: implement key
  Key? get key => throw UnimplementedError();

  @override
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringDeep(
      {String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel
          .debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow(
      {String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel
          .debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}