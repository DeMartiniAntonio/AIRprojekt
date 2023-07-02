import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/vendingmachineapp/Devices.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';
import 'package:flutterapp/vendingmachineapp/User.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class RevolutPay implements PaymentInterface {
  String order_id = "";
  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(
      DateTime.now());

  @override
  executePayment(BuildContext context) async {
    final body = jsonEncode({
      "amount": 5,
      "merchant_order_ext_ref": "Order test",
      "email": "test.customer@example.com",
      "currency": "EUR"
    });

    final response = await http.post(
      Uri.parse('https://sandbox-merchant.revolut.com/api/1.0/orders'),
      headers: {
        'Authorization': 'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
        'Content-Type': 'application/json'
      },

      body: body,
    );

    if (response.statusCode == 201) {
      Uri uri = Uri.parse(json.decode(response.body)['checkout_url']);
      order_id = json.decode(response.body)['id'];
      TextEditingController uriController = TextEditingController(

          text: uri.toString());

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
    }
    isPaymentDone(context);
  }
  @override
  isPaymentDone(BuildContext context) async {
    bool paymentPending = true;
    var order = 'https://sandbox-merchant.revolut.com/api/1.0/orders';

    int counter = 0;
    while (paymentPending && counter <= 24) {
      var paymentStatus = await http.get(Uri.parse('$order/$order_id'),
        headers: {
          'Authorization': 'Bearer sk_tRxDMwdEfNPy5m0Di-a6LYzcoL4uxMcYZY2Qm-7LU7K6GGgwPC-cHKIOK9nnVZ3n',
          'Content-Type': 'application/json'
        },
      );

      if (json.decode(paymentStatus.body)['state'] == "COMPLETED") {
        paymentPending = false;
        updateDevice(context);
        savingEvent(context);
        sendMqttSignal(context);
        Devices.deleteDevice();
        Navigator.pushNamed(context, '/GeneratedQR_code_scanWidget');
      } else {
        await Future.delayed(Duration(seconds: 5));
        counter = counter + 1;
      }
    }
  }

  @override
  Future<void> updateDevice(BuildContext context) async {
    int stock = Devices.getScanedDevice()!.stock;
    stock = stock - 1;
    int idDevice = Devices.getScanedDevice()!.device_ID;

    final body = jsonEncode({
      "lat": Devices
          .getScanedDevice()
          ?.lat,
      "long": Devices
          .getScanedDevice()
          ?.long,
      "stock": stock,
      "price": Devices
          .getScanedDevice()
          ?.price,
      "active": Devices
          .getScanedDevice()
          ?.active,
    });


    await http.put(Uri.parse(
        'https://air2218.mobilisis.hr/api/api/VendingMachine/UpdateDevice?id=$idDevice'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }

  @override
  Future<http.Response> savingEvent(BuildContext context) async {
    final body = jsonEncode({
      "user_id": User
          .getLoggedInUser()
          ?.user_ID,
      "device_id": Devices
          .getScanedDevice()
          ?.device_ID,
      "date_time": formattedDateTime,
    });

    final response = await http.post(Uri.parse(
        'https://air2218.mobilisis.hr/api/api/VendingMachine/AddEvent'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    return response;
  }

  MqttServerClient? client;
  @override
  sendMqttSignal(BuildContext context) async {
    final client = MqttServerClient('test.mosquitto.org', 'AIR2218');
    client.logging(on: true);

    await client.connect(); // Connect to the broker
    final builder = MqttClientPayloadBuilder();

    builder.addString("1");
    print("poslano");
    client.publishMessage(
        'AIR2218/vrata', MqttQos.exactlyOnce, builder.payload!);
    client.disconnect();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '';
  }

  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    throw UnimplementedError();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // TODO: implement debugFillProperties
  }

  @override
  // TODO: implement key
  Key? get key => throw UnimplementedError();

  @override
  DiagnosticsNode toDiagnosticsNode({String? name, DiagnosticsTreeStyle? style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringDeep({String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow({String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }
}
