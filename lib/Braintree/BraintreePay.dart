import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';

import '../IPayment/PaymentInterface.dart';

class BraintreePay implements PaymentInterface {
  @override
  Future<void> executePayment(BuildContext context, PaymentListener listener) async {
    Map<String, dynamic>? paymentIntent;
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Braintree Payment'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Buy Now'),
                onPressed: () async {
                  await executePayment(context, listener);
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

}