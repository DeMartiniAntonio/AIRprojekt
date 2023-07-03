import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';


class ThirdModule implements PaymentInterface {
  @override
  void executePayment(BuildContext context, PaymentListener listener) {
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
}
