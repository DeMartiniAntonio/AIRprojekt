import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class PaymentInterface {
  void executePayment(BuildContext context, PaymentListener listener);

}

abstract class PaymentListener{
  void onSuccess(BuildContext context);
  void onFailure(BuildContext context);
}
