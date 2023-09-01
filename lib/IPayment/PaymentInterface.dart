import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class PaymentInterface {
  void executePayment(BuildContext context, PaymentListener listener, String amount);
  Widget getPayButton(BuildContext context);
}

abstract class PaymentListener{
  void onSuccess(BuildContext context);
  void onFailure(BuildContext context);
}
