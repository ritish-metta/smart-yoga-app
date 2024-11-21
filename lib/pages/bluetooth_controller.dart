import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  final devices = <DiscoveredDevice>[].obs;
  final isScanning = false.obs;
  final isConnecting = false.obs; 
  final isConnected = false.obs; 
  final connectedDeviceId = ''.obs; 
  final connectedDeviceName = ''.obs; 
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connectionSubscription;

  get isFunctionInProgress => null;

  get functionStatus => null;

  get totalYogaSessions => null;

  get warmUpCount => null;

  get relaxationCount => null;

  @override
  void onInit() {
    super.onInit();

    // Attempt to restore connection state if needed
    if (connectedDeviceId.isNotEmpty) {
      reconnectToDevice();
    }
  }

  Future<void> scanDevices() async {
    if (isScanning.value) return;
    isScanning.value = true;

    devices.clear();

    try {
      _scanSubscription = _ble.scanForDevices(
        withServices: [], 
        scanMode: ScanMode.lowLatency,
      ).listen((device) {
        if (!devices.any((d) => d.id == device.id)) {
          devices.add(device);
        }
      });

      await Future.delayed(const Duration(seconds: 10));
      await _scanSubscription?.cancel();
    } catch (e) {
      print("Error starting scan: $e");
    } finally {
      isScanning.value = false;
    }
  }

  Future<void> connectToDevice(String deviceId) async {
    if (isConnected.value || isConnecting.value) return; 
    isConnecting.value = true;

    try {
      _connectionSubscription = _ble.connectToDevice(
        id: deviceId,
        connectionTimeout: const Duration(seconds: 5),
      ).listen((state) {
        switch (state.connectionState) {
          case DeviceConnectionState.connected:
            isConnected.value = true;
            connectedDeviceId.value = deviceId;

            final device = devices.firstWhereOrNull((d) => d.id == deviceId);
            connectedDeviceName.value = device?.name ?? "Unknown Device";

            break;
          case DeviceConnectionState.disconnected:
            isConnected.value = false;
            connectedDeviceId.value = '';
            connectedDeviceName.value = '';
            break;
          default:
            break;
        }
      }, onError: (error) {
        print("Connection error: $error");
      });
    } catch (e) {
      print("Error connecting to device: $e");
    } finally {
      isConnecting.value = false;
    }
  }

  Future<void> reconnectToDevice() async {
    if (connectedDeviceId.value.isEmpty || isConnected.value) return;

    await connectToDevice(connectedDeviceId.value);
  }

  Future<void> disconnectDevice() async {
    if (!isConnected.value) return;

    try {
      await _connectionSubscription?.cancel();
      isConnected.value = false;
      connectedDeviceId.value = '';
      connectedDeviceName.value = '';
    } catch (e) {
      print("Error disconnecting: $e");
    }
  }

  @override
  void onClose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    super.onClose();
  }

  startWarmUp() {}

  beginRelaxationMode() {}
}
