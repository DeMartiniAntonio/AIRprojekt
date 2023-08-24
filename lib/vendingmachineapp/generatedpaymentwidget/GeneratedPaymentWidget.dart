import 'package:flutter/material.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/Button_OtherWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/Button_RevolutWidget.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/GeneratedLabel_PaymentWidget.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/vendingmachineapp/generatedpaymentwidget/generated/Button_PayNow.dart';


/* Frame Payment
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedPaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(

        child: ClipRRect(
      borderRadius: BorderRadius.zero,
          child: Container(
        width: 390.0,
        height: 844.0,
            child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0.0,
                bottom: null,
                width: null,
                height: 85.0,
                child: GeneratedLabel_PaymentWidget(),
              ),
              Positioned(
                left: 39.0,
                top: null,
                right: 39.0,
                bottom: null,
                width: null,
                height: 62.04999923706055,
                child: TransformHelper.translate(
                    x: 0.00,
                    y: -35.98,
                    z: 0,
                    child: Button_OtherWidget()),
              ),
              Positioned(
                left: 39.0,
                top: null,
                right: 39.0,
                bottom: null,
                width: null,
                height: 62.04999923706055,
                child: TransformHelper.translate(
                    x: 0.00,
                    y: 64.02,
                    z: 0,
                    child: Button_PayNow()),
              ),

              Positioned(
                left: 39.0,
                top: null,
                right: 39.0,
                bottom: null,
                width: null,
                height: 62.04999923706055,
                child: TransformHelper.translate(
                    x: 0.00,
                    y: -135.98,
                    z: 0,
                    child: Button_RevolutWidget()),
              ),

              Positioned(
                left: 39.0,
                top: null,
                right: 39.0,
                bottom: null,
                width: null,
                height: 62.04999923706055,
                child: TransformHelper.translate(
                    x: 0.00,
                    y: -59,
                    z: 0,
                    child: Text("BOK")),
              ),

              Positioned(
                left: null,
                top: null,
                right: null,
                bottom: null,
                width: 213.64999389648438,
                height: 50.45000076293945,
                child: TransformHelper.translate(
                    x: -0.18,
                    y: -247.77,
                    z: 0,
                    child: Text(
                      '''Choose a payment method''',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.210227219954781,
                        fontSize: 23.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0),

                        /* letterSpacing: 0.0, */
                      ),
                    )),
              )
            ]),
      ),
    ));
  }
}
