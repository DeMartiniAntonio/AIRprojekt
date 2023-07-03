import 'dart:convert';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/IPayment/PaymentInterface.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '/vendingmachineapp/Devices.dart';
import '/vendingmachineapp/User.dart';

class StripePay implements PaymentInterface {

  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(
      DateTime.now());

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

    final response = await http.post(
      Uri.parse('https://air2218.mobilisis.hr/api/api/VendingMachine/AddEvent'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    return response;
  }

  MqttServerClient? client;

  @override
  Future<void> sendMqttSignal(BuildContext context) async {
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
  Future<void> executePayment(BuildContext context) async {
    Map<String, dynamic>? paymentIntent;
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stripe Payment'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Buy Now'),
                onPressed: () async {
                  await executePayment(context);
                },
              ),
            ],
          ),
        ),
      );
    }
    try {
      paymentIntent = await createPaymentIntent('1000', 'EUR');

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent![
            'client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'Test',
          ))
          .then((value) {});

      isPaymentDone(context);
    } catch (err) {
      print(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51NOKz4GAMBmTAYlA5udflpJ8TFyLoYZ1P6jZVDqIFo1tJ8QYI1mrCPNCck1Dlv8VU6yCZcEPdgoBtNfFoHel5LAT00QezbQE16',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,

      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }

  }

  @override
  Future<void> isPaymentDone(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfull");
        updateDevice(context);
        savingEvent(context);
        sendMqttSignal(context);
        Devices.deleteDevice();
        Navigator.pushNamed(context, '/GeneratedQR_code_scanWidget');
      });
    } catch (e) {
      print('$e');
      await Future.delayed(Duration(seconds: 5));
    }
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
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringDeep(
      {String prefixLineOne = '', String? prefixOtherLines, DiagnosticLevel minLevel = DiagnosticLevel
          .debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow(
      {String joiner = ', ', DiagnosticLevel minLevel = DiagnosticLevel
          .debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}