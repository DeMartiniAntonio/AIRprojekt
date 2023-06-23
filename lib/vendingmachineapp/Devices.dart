class Devices {
  int device_ID;
  double lat;
  double long;
  int stock;
  double price;
  bool active;

  Devices({
    required this.device_ID,
    required this.lat,
    required this.long,
    required this.stock,
    required this.price,
    required this.active,
  });

  static Devices? _getDevice;

  static Devices? get getDevice => _getDevice;

  static void saveDevice(Devices devices) {
    _getDevice = devices;
  }

  static Devices? getScanedDevice() {
    return _getDevice;
  }

  static void deleteDevice() {
    _getDevice = null;
  }

}