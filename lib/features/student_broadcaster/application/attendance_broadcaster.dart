import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';

class AttendanceBroadcaster {
  AttendanceBroadcaster(this._blePeripheral);

  final FlutterBlePeripheral _blePeripheral;

  Future<void> start() async {
    await _blePeripheral.start();
  }

  Future<void> stop() async {
    await _blePeripheral.stop();
  }
}
