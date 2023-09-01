import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/IPayment/PaymentInterface.dart';

import '../PaymentListeners/EndOfPayment.dart';
import '../helpers/transform/transform.dart';

class RevolutPay implements PaymentInterface {
  String order_id = "";

  @override
  executePayment(
      BuildContext context, PaymentListener listener, String amount) async {
    final body = jsonEncode({
      "amount": 5,
      "merchant_order_ext_ref": "Order test",
      "email": "test.customer@example.com",
      "currency": "EUR"
    });

    print("uso");

    final response = await http.post(
      Uri.parse('https://sandbox-merchant.revolut.com/api/1.0/orders'),
      headers: {
        'Authorization':
            'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
        'Content-Type': 'application/json'
      },
      body: body,
    );

    if (response.statusCode == 201) {
      Uri uri = Uri.parse(json.decode(response.body)['checkout_url']);
      order_id = json.decode(response.body)['id'];
      TextEditingController uriController =
          TextEditingController(text: uri.toString());

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Copy URI in browser!'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: uriController,
                  readOnly: true,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: uri.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('URI copied to clipboard')),
                    );
                  },
                  child: Text('Copy URI'),
                ),
              ],
            ),
          );
        },
      );
    }
    isPaymentDone(context, listener);
  }

  isPaymentDone(BuildContext context, PaymentListener listener) async {
    bool paymentPending = true;
    var order = 'https://sandbox-merchant.revolut.com/api/1.0/orders';

    int counter = 0;
    while (paymentPending && counter <= 24) {
      var paymentStatus = await http.get(
        Uri.parse('$order/$order_id'),
        headers: {
          'Authorization':
              'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
          'Content-Type': 'application/json'
        },
      );

      if (json.decode(paymentStatus.body)['state'] == "COMPLETED") {
        paymentPending = false;

        listener.onSuccess(context);
      } else {
        await Future.delayed(Duration(seconds: 5));
        counter = counter + 1;
      }
    }
    listener.onFailure(context);
  }

  Widget getPayButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        EndOfPayment eop = new EndOfPayment();
        PaymentInterface revolut = RevolutPay();
        revolut.executePayment(context, eop, "50");
      },
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 29, 53, 87),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Revolut',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '';
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
      {String prefixLineOne = '',
      String? prefixOtherLines,
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow(
      {String joiner = ', ',
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }
}
