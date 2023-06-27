import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Devices.dart';
import 'package:flutterapp/vendingmachineapp/User.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class EndOfPayment {
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


    await http.put(Uri.parse('https://air2218.mobilisis.hr/api/api/VendingMachine/UpdateDevice?id=$idDevice'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

  }

  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());
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



  MqttServerClient? client;

  void sendMqttSignal() async {
    final client = MqttServerClient('test.mosquitto.org', 'AIR2218');
    client.logging(on: true);

    await client.connect(); // Connect to the broker
    final builder = MqttClientPayloadBuilder();

    builder.addString("1");
    print("poslano");
    client.publishMessage('AIR2218/vrata', MqttQos.exactlyOnce, builder.payload!);
    client.disconnect();

  }
}




