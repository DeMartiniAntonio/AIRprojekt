import 'package:flutter/material.dart';

class Button_PayNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => PaymentPopup(),
        );
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

class PaymentPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payment Confirmation'),
      content: Text('Are you sure you want to continue payment?'),
      actions: [
        TextButton(
          onPressed: () {
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
  }
}