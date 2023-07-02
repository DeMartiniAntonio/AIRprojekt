import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class PaymentInterface {
  void executePayment(BuildContext context);
  void isPaymentDone(BuildContext context);
  void updateDevice(BuildContext context);
  void savingEvent(BuildContext context);
  void sendMqttSignal(BuildContext context);
}
