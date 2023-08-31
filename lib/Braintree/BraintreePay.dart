import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class BraintreePay implements PaymentInterface {
  String nonce = "";
  String amount = "5001.01";
  @override
  Future<void> executePayment(BuildContext context, PaymentListener listener) async {
    final cardRequest = BraintreeCreditCardRequest(
      cardNumber: '4111111111111111',
      expirationMonth: '12',
      expirationYear: '2023',
      cvv: '367',
    );

    BraintreePaymentMethodNonce? cardResult = await Braintree.tokenizeCreditCard(
      'sandbox_x6nqjyjs_r8mzn7scvccj9gqr',
      cardRequest,
    );
    print('Card Nonce: ${cardResult?.nonce}');

    final dropInRequest = BraintreeDropInRequest(
      clientToken: 'sandbox_x6nqjyjs_r8mzn7scvccj9gqr',
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: '20',
        currencyCode: 'EUR',
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: '20',
        displayName: 'Example company',
      ),
    );


      BraintreeDropInResult? dropInResult = await BraintreeDropIn.start(dropInRequest);

      if (dropInResult != null) {
        print('Nonce: ${dropInResult.paymentMethodNonce.nonce}');
        nonce= dropInResult.paymentMethodNonce.nonce;
        // izvrši plaćanje
        postNonceToServer(context,listener);

      }else {
        print('Selection was canceled.');
        Fluttertoast.showToast(
            msg: "Odustali ste od plaćanja!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
         // Payment failure handling
      }
  }
  Future<void> postNonceToServer(BuildContext context,PaymentListener listener) async {

    final url = Uri.parse('http://10.85.12.199:5000/client_token');
    final response = await http.post(
      url,
      body: {'payment_method_nonce': nonce, 'amount': amount},
    );

    Fluttertoast.showToast(
        msg: response.statusCode.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.statusCode == 200) {
      // Successful response
      print('Payment successful');

      // You can implement further actions here
      listener.onSuccess(context);
    } else {
      // Error handling
      print('Payment failed');
      // You can handle errors and take appropriate actions
      listener.onFailure(context);
    }
  }
}

