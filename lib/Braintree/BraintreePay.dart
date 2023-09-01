import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../PaymentListeners/EndOfPayment.dart';

class BraintreePay implements PaymentInterface {
  String nonce = "";
  String amount = "20";
  @override
  Future<void> executePayment(BuildContext context, PaymentListener listener, String amount) async {
    this.amount=amount;
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
        Fluttertoast.showToast(
            msg: "Transakcija je uspješna!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

    if (response.statusCode == 200) {
      // Successful response
      print('Payment successful');

    } else {
      // Error handling
      print('Payment failed');
      listener.onFailure(context);
    }
  }

   Widget getPayButton(BuildContext context){
     return GestureDetector(
       onTap: () async{
         EndOfPayment kraj = new EndOfPayment();
         PaymentInterface payer = BraintreePay();
         payer.executePayment(context, kraj, "50");
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
               'Braintree',
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
}

