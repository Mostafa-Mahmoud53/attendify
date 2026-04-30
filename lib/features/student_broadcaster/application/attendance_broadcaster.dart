import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';

class AttendanceBroadcaster {
  AttendanceBroadcaster(this._blePeripheral);

  final FlutterBlePeripheral _blePeripheral;

  Future<void> start() async {
    await _blePeripheral.start(
      advertiseData: AdvertiseData(
        includeDeviceName: true,
        localName: 'Attendify',
        serviceUuids: const ['0000180D-0000-1000-8000-00805F9B34FB'],
      ),
    );
  }

  Future<void> stop() async {
    await _blePeripheral.stop();
  }
}
