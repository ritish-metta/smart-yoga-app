import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class ControlPanelScreen extends StatelessWidget {
  const ControlPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.menu, color: Colors.white, size: 30),
        backgroundColor: Colors.deepPurple,
      ),
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (controller) {
          return Column(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "Control Panel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                            controller.isConnected.value
                                ? "Connected to: ${controller.connectedDeviceId.value}"
                                : "Not Connected",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    onPressed: controller.isConnected.value
                        ? () => controller.startWarmUp()
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(350, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: const Text(
                      "Start Warm-Up",
                      style: TextStyle(fontSize: 23),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    onPressed: controller.isConnected.value
                        ? () => controller.beginRelaxationMode()
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(350, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: const Text(
                      "Begin Relaxation Mode",
                      style: TextStyle(fontSize: 23),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isFunctionInProgress.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.functionStatus.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.functionStatus.value,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          );
        },
      ),
    );
  }
}

class BluetoothController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final isConnected = false.obs;
  final connectedDeviceId = ''.obs;
  final isFunctionInProgress = false.obs;
  final functionStatus = ''.obs;

  get totalYogaSessions => null;

  get warmUpCount => null;

  get relaxationCount => null;

  get connectedDeviceName => null;

  get devices => null;

  get isScanning => null;

  void startWarmUp() async {
    if (isFunctionInProgress.value) return;
    isFunctionInProgress.value = true;
    functionStatus.value = 'Starting Warm-Up...';
    await Future.delayed(const Duration(seconds: 3)); 
    functionStatus.value = 'Warm-Up Started';
    isFunctionInProgress.value = false;
  }

  void beginRelaxationMode() async {
    if (isFunctionInProgress.value) return;
    isFunctionInProgress.value = true;
    functionStatus.value = 'Starting Relaxation Mode...';
    await Future.delayed(const Duration(seconds: 3)); 
    functionStatus.value = 'Relaxation Mode Started';
    isFunctionInProgress.value = false;
  }

  scanDevices() {}

  void disconnectDevice() {}

  void connectToDevice(id) {}
}
