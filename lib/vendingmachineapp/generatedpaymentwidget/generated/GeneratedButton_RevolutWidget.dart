import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutterapp/vendingmachineapp/Devices.dart';
import 'package:flutterapp/vendingmachineapp/User.dart';
import 'package:intl/intl.dart';



class GeneratedButton_RevolutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () async{
         startRevolutPayment(context);
       },

      child: Container(
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
              child: Container(
                width: 312.0,
                height: 62.04999923706055,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36.54999923706055),
                  child: Container(
                    color: Color.fromARGB(255, 29, 53, 87),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 97.0,
              top: null,
              right: 88.0,
              bottom: null,
              width: null,
              height: 42.0,
              child: TransformHelper.translate(
                  x: 0.00, y: 2.98, z: 0, child: Text(
                '''Revolut''',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.2102272780396295,
                  fontSize: 30.600000381469727,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),

                  /* letterSpacing: 0.0, */
                ),
              )),
            )
          ]),
    ));
  }
}

Future<void> startRevolutPayment(BuildContext context) async {
  final body= jsonEncode({
    "amount": 5,
    "merchant_order_ext_ref": "Order test",
    "email": "test.customer@example.com",
    "currency": "EUR"
  });

  final response =await http.post(Uri.parse('https://sandbox-merchant.revolut.com/api/1.0/orders'),
      headers: {
    'Authorization': 'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
    'Content-Type': 'application/json'
      },

      body: body,
  );


  if(response.statusCode==201){
    Uri uri =Uri.parse(json.decode(response.body)['checkout_url']);
    String order_id =json.decode(response.body)['id'];
    print (uri);
    TextEditingController uriController = TextEditingController(text: uri.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Copy URI in browser!'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: uriController,
                readOnly: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: uri.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('URI copied to clipboard')),
                  );
                },
                child: Text('Copy URI'),
              ),
            ],
          ),
        );
      },
    );

    bool paymentPending = true;
    var order='https://sandbox-merchant.revolut.com/api/1.0/orders';

    int counter=0;
    while (paymentPending&&counter<=24) {

      var paymentStatus = await http.get(Uri.parse('$order/$order_id'),
        headers: {
          'Authorization': 'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
          'Content-Type': 'application/json'
        },
      );


      // Check if the payment status has changed to "paid"
      if (json.decode(paymentStatus.body)['state'] == "COMPLETED") {
        paymentPending = false;
        savingEvent();
        updateDevice();
        Navigator.pushNamed(context, '/GeneratedQR_code_scanWidget');

      } else {
        await Future.delayed(Duration(seconds: 5));
        counter=counter+1;
      }

    }

  }
}

Future<void> updateDevice() async {

  int stock =Devices.getScanedDevice()!.stock;
  stock=stock-1;
  int idDevice =Devices.getScanedDevice()!.device_ID;

  final body = jsonEncode({
    "lat": Devices.getScanedDevice()?.lat,
    "long": Devices.getScanedDevice()?.long,
    "stock": stock,
    "price": Devices.getScanedDevice()?.price,
    "active": Devices.getScanedDevice()?.active,
  });


  final response = await http.put(Uri.parse('https://air2218.mobilisis.hr/api/api/VendingMachine/UpdateDevice?id=$idDevice'),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );



}

DateTime now = DateTime.now();
String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);

Future<http.Response> savingEvent() async {

  final body = jsonEncode({
    "user_id": User.getLoggedInUser()?.user_ID,
    "device_id": Devices.getScanedDevice()?.device_ID,
    "date_time": formattedDateTime,
  });

  final response = await http.post(Uri.parse('https://air2218.mobilisis.hr/api/api/VendingMachine/AddEvent'),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  return response;
}



