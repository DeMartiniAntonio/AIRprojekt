import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/PaymentListeners/EndOfPayment.dart';
import '../../../IPayment/PaymentInterface.dart';
import '../../../ThirdModule/ThirdModule.dart';

class Button_PayNow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () async{
          EndOfPayment eop= new EndOfPayment();
          PaymentInterface payer = ThirdModule();
          payer.executePayment(context, eop, "50");
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
            'Pay Now',
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




