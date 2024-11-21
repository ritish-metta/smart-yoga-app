import 'package:flutter/material.dart';

class OTAUpdateWidget extends StatefulWidget {
  const OTAUpdateWidget({super.key});

  @override
  State<OTAUpdateWidget> createState() => _OTAUpdateWidgetState();
}

class _OTAUpdateWidgetState extends State<OTAUpdateWidget> {
  String currentVersion = "1.0.0";
  String latestVersion = "1.1.0";
  bool isCheckingUpdate = false;
  bool isUpdating = false;

  void _checkForUpdates() async {
    setState(() => isCheckingUpdate = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isCheckingUpdate = false);
  }

  void _performUpdate() async {
    setState(() => isUpdating = true);
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isUpdating = false;
      currentVersion = latestVersion;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Firmware updated successfully!")),
    );
  }

  Widget _buildUpdateCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onAction,
    required String buttonLabel,
    bool isLoading = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(buttonLabel),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTA Updates",style: TextStyle(fontSize: 30,color:Color.fromARGB(255, 250, 244, 244))),
        backgroundColor: const Color.fromARGB(255, 102, 1, 253),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Firmware Updates",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildUpdateCard(
              title: "Current Firmware Version",
              subtitle: "Version: $currentVersion",
              icon: Icons.system_update,
              color: Colors.blue,
              onAction: () {},
              buttonLabel: "Up-To",
              isLoading: false,
            ),
            _buildUpdateCard(
              title: "Check for Updates",
              subtitle: isCheckingUpdate
                  ? "Checking for updates..."
                  : (currentVersion == latestVersion
                      ? "You're on the latest version."
                      : "New version available: $latestVersion"),
              icon: Icons.cloud_download,
              color: Colors.teal,
              onAction: _checkForUpdates,
              buttonLabel: "Check",
              isLoading: isCheckingUpdate,
            ),
            if (currentVersion != latestVersion)
              _buildUpdateCard(
                title: "Update Firmware",
                subtitle: "New version available: $latestVersion",
                icon: Icons.update,
                color: Colors.green,
                onAction: _performUpdate,
                buttonLabel: "Till now",
                isLoading: isUpdating,
              ),
          ],
        ),
      ),
    );
  }
}
