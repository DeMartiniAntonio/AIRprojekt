import 'dart:convert';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:flutterapp/vendingmachineapp/Devices.dart';
import 'package:http/http.dart' as http;

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 53, 87),
        title: Text("Scan QR Code"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Color.fromARGB(255, 29, 53, 87),
                borderRadius: 10,
                borderWidth: 20,

                cutOutSize: MediaQuery.of(context).size.width *0.8,),

            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

      controller.resumeCamera();


    controller.scannedDataStream.listen((scanData) async {
      bool isDeviceExist = await getDevice(scanData.code.toString());


        int? stock= Devices.getScanedDevice()?.stock;


      if (isDeviceExist && stock!>0) {
        controller.stopCamera();
        Navigator.pushNamed(context, '/GeneratedPaymentWidget');
      }
      else if(isDeviceExist && stock==0)
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(

            title: Text("Device is out of products!"),
            actions: [
              TextButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        );
      }
      else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(

            title: Text("QR code doesnt exist!"),
            actions: [
              TextButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        );
      }

    });
  }

}
var check='https://air2218.mobilisis.hr/api/api/VendingMachine/GetOne';

Future<bool> getDevice(String code) async {
  final response =await http.get(Uri.parse('$check?id=$code&ObjectType=Device'));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    Devices getDev=Devices(
      device_ID: jsonData['device_ID'],
      lat: jsonData['lat'],
      long: jsonData['long'],
      stock: jsonData['stock'],
      price: jsonData['price'],
      active: jsonData['active'],
    );

    Devices.saveDevice(getDev);

    return true;

  } else {

    return false;
  }
}

class ButtonQR extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context)  {
            return Scaffold(
              body: QRCodeScanner(),


            );
          },
        )
        );

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
                    '''Scan QR code''',
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
