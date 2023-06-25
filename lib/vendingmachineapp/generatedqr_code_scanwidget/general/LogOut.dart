import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/vendingmachineapp/User.dart';


class LogOut extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        User.deleteLoggedInUser();
        Navigator.pushNamed(context, '/GeneratedLoginWidget');

      },
      child: Container(
        width: 312.0,
        height: 67.1500015258789,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.54999923706055),
          boxShadow: kIsWeb
              ? []
              : [
            BoxShadow(
              color: Color.fromARGB(63, 0, 0, 0),
              offset: Offset(4.25, 4.25),
              blurRadius: 4.25,
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
                height: 67.1500015258789,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36.54999923706055),
                  child: Container(
                    color: Color.fromARGB(255, 29, 53, 87),
                  ),
                ),
              ),
              Positioned(
                left: null,
                top: null,
                right: null,
                bottom: null,
                width: null,
                height: 38.0,
                child: TransformHelper.translate(
                  x: 0.00,
                  y: 1.42,
                  z: 0,
                  child: Text(
                    '''Log out''',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),

                      /* letterSpacing: 0.0, */
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

}
