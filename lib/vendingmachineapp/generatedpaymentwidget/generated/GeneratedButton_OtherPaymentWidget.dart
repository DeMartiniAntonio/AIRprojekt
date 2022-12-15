import 'package:flutter/material.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/GeneratedOtherWidget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/GeneratedRectangle43Widget8.dart';
import 'package:flutterapp/helpers/transform/transform.dart';

/* Group Button_OtherPayment
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedButton_OtherPaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.0,
      height: 62.04999923706055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.54999923706055),
        boxShadow: kIsWeb
            ? []
            : [
                BoxShadow(
                  color: Color.fromARGB(63, 0, 0, 0),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 4.0,
                )
              ],
      ),
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0.0,
              top: null,
              right: 0.0,
              bottom: null,
              width: null,
              height: 62.04999923706055,
              child: GeneratedRectangle43Widget8(),
            ),
            Positioned(
              left: 106.0,
              top: null,
              right: 109.0,
              bottom: null,
              width: null,
              height: 42.0,
              child: TransformHelper.translate(
                  x: 0.00, y: 2.98, z: 0, child: GeneratedOtherWidget()),
            )
          ]),
    );
  }
}
