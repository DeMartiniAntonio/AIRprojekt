import 'package:flutter/material.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/helpers/svg/svg.dart';

import '../generatedloginwidget/generated/Logo.dart';


class GeneratedQR_code_scanWidget extends StatelessWidget {
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
                  left: null,
                  top: null,
                  right: null,
                  bottom: null,
                  width: 82.21957397460938,
                  height: 73.0456771850586,
                  child: TransformHelper.translate(
                      x: 1.11, y: -343.48, z: 0, child: Logo()),
                ),
              Positioned(
                left: null,
                top: null,
                right: null,
                bottom: null,
                width: 213.64999389648438,
                height: 50.45000076293945,
                child: TransformHelper.translate(
                    x: 0.82,
                    y: -240.77,
                    z: 0,
                    child: Text(
                      '''Scan the QR code od vending machine!''',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.2102272931267233,
                        fontSize: 17.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0),

                        /* letterSpacing: 0.0, */
                      ),
                    )),
              ),
                Positioned(
                  left: 39.0,
                  top: null,
                  right: 39.0,
                  bottom: null,
                  width: null,
                  height: 67.1500015258789,
                  child: TransformHelper.translate(
                      x: 0.00,
                      y: 39.58,
                      z: 0,
                      child: ButtonQR()),
                ),

            ]),
      ),
    ));
  }

  ButtonQR() {}
}

