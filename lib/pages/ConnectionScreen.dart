import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_yoga_mat/pages/bluetooth_controller.dart';

class Connectionscreen extends StatelessWidget {
  const Connectionscreen({super.key});

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
                          "Make a Connection",
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
                                ? "Connected to: ${controller.connectedDeviceName.value}"
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
                    onPressed: () => controller.scanDevices(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(350, 55),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: Text(
                      controller.isScanning.value ? "Scanning..." : "Scan",
                      style: const TextStyle(fontSize: 23),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.devices.isEmpty && !controller.isScanning.value) {
                  return const Center(
                    child: Text(
                      "No devices found",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.devices.length,
                    itemBuilder: (context, index) {
                      final device = controller.devices[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(device.name.isEmpty
                              ? "Unknown Device"
                              : device.name),
                          subtitle: Text(device.id),
                          trailing: controller.isConnected.value &&
                                  controller.connectedDeviceId.value == device.id
                              ? ElevatedButton(
                                  onPressed: () {
                                    controller.disconnectDevice();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 250, 94, 3),
                                  ),
                                  child: const Text("Disconnect"),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    controller.connectToDevice(device.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text("Connect"),
                                ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
