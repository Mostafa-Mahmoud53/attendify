import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/storage/storage_service.dart';
import '../../../shared/widgets/base_screen.dart';

class LiveScannerScreen extends StatefulWidget {
  const LiveScannerScreen({super.key, required this.sessionCode});

  final String sessionCode;

  @override
  State<LiveScannerScreen> createState() => _LiveScannerScreenState();
}

class _LiveScannerScreenState extends State<LiveScannerScreen> {
  final List<String> _students = [];
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Live Session Active',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PulsingDot(color: Colors.red),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Session ${widget.sessionCode}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${_students.length} Students Recorded',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: ListView.separated(
              itemCount: _students.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final studentId = _students[index];
                return Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(studentId),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startScan() {
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) async {
      for (final result in results) {
        final id = result.device.id.id;
        if (_students.contains(id)) {
          continue;
        }

        if (!_isValidPacket(result)) {
          continue;
        }

        setState(() {
          _students.add(id);
        });

        await serviceLocator<StorageService>().addSessionAttendee(
          sessionId: widget.sessionCode,
          studentId: id,
        );

        await _sendStopSignal(result.device);
      }
    });

    FlutterBluePlus.startScan(timeout: const Duration(minutes: 5));
  }

  bool _isValidPacket(ScanResult result) {
    return result.rssi > -80;
  }

  Future<void> _sendStopSignal(BluetoothDevice device) async {
    final services = await device.discoverServices();
    for (final service in services) {
      for (final characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          await characteristic.write([1], withoutResponse: true);
          return;
        }
      }
    }
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.color});

  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 1).animate(_controller),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
