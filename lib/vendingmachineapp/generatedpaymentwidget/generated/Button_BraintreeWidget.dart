import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../IPayment/PaymentInterface.dart';
import '../../../Braintree/BraintreePay.dart';
import 'package:flutterapp/PaymentListeners/EndOfPayment.dart';

class Button_BraintreeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async{
        EndOfPayment kraj= new EndOfPayment();
        PaymentInterface payer = BraintreePay();
        payer.executePayment(context, kraj);
      },

      child: Container(
        width: 200.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 58, 92, 143),
          borderRadius: BorderRadius.circular(36.54999923706055),
        ),
        child: Center(
          child: Text(
            'Braintree',
            style: TextStyle(
              height: 1.2102272780396295,
              fontSize: 30.600000381469727,
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
