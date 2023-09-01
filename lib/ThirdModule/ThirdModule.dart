import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';

import '../PaymentListeners/EndOfPayment.dart';


class ThirdModule implements PaymentInterface {
  @override
  void executePayment(BuildContext context, PaymentListener listener, String amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Continue payment'),
          content: Text('Are you sure you want to continue?'),
          actions: [
            TextButton(
              onPressed: () {
                listener.onFailure(context);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Payment Cancelled'),
                      content: Text('Payment cancelled.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                );

              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                listener.onSuccess(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Payment Successful'),
                    content: Text('Payment successful.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  Widget getPayButton (BuildContext context){
    return GestureDetector(
      onTap: () async{
        EndOfPayment eop= new EndOfPayment();
        PaymentInterface payer = ThirdModule();
        payer.executePayment(context, eop, "50");
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
            'Pay now',
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

