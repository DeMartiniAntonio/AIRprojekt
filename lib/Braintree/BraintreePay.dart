import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';

class BraintreePay implements PaymentInterface {
  @override
  Future<void> executePayment(BuildContext context, PaymentListener listener) async {
    final cardRequest = BraintreeCreditCardRequest(
      cardNumber: '4111111111111111',
      expirationMonth: '12',
      expirationYear: '2021',
      cvv: '367',
    );

    BraintreePaymentMethodNonce? cardResult = await Braintree.tokenizeCreditCard(
      'sandbox_x6nqjyjs_r8mzn7scvccj9gqr',
      cardRequest,
    );
    print('Card Nonce: ${cardResult?.nonce}');

    final paypalRequest = BraintreePayPalRequest(amount: '13.37');

    BraintreePaymentMethodNonce? paypalResult = await Braintree.requestPaypalNonce(
      'sandbox_x6nqjyjs_r8mzn7scvccj9gqr',
      paypalRequest,
    );
    if (paypalResult != null) {
      print('PayPal Nonce: ${paypalResult.nonce}');
    } else {
      print('PayPal flow was canceled.');
    }

    final dropInRequest = BraintreeDropInRequest(
      clientToken: 'sandbox_x6nqjyjs_r8mzn7scvccj9gqr',
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: '4.20',
        currencyCode: 'USD',
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: '4.20',
        displayName: 'Example company',
      ),
    );


      BraintreeDropInResult? dropInResult = await BraintreeDropIn.start(dropInRequest);

      if (dropInResult != null) {
        print('Nonce: ${dropInResult.paymentMethodNonce.nonce}');
        listener.onSuccess(context); // Payment success handling
      } else {
        print('Selection was canceled.');
        listener.onFailure(context); // Payment failure handling
      }
  }
}
