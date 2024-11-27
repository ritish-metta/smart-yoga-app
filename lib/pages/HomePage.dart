import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/ControlPanelScreen.dart';
import 'package:smart_yoga_mat/MusicControlWidget.dart';
import 'package:smart_yoga_mat/StreakApp.dart';
import 'package:smart_yoga_mat/otaupdateWidget.dart';
import 'package:smart_yoga_mat/pages/ConnectionScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> info = [
    {
      'image': 'https://i.pinimg.com/736x/fa/b2/76/fab276dcd45b8f74f7d864b856a69a3d.jpg',
      'title': 'Legs Toning',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjHD08DP3eyA5YJaxbgWfjcqnLoo_AVA3-gg&s',
      'title': 'Glutes Workout',
    },
    {
      'image': 'https://t4.ftcdn.net/jpg/03/28/19/23/360_F_328192317_u5OEL6ECgH8OMJYqa2Rh5Gv70JNuKlM5.jpg',
      'title': 'Core Strengthening',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuGBEtYm2V3w43g142B4Qgm_j4gQ8bATWC3A&s',
      'title': 'Upper Body Toning',
    },
  ];

  Widget buildFeatureButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to let gradient shine through
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.05, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  const Text(
                    "Training",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,color:Color.fromARGB(255, 254, 251, 251)),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_back_ios, size: 20),
                  const SizedBox(width: 10),
                  const Icon(Icons.calculate_outlined, size: 30, color: Color.fromARGB(255, 255, 255, 255)),
                  const SizedBox(width: 15),
                  const Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
              const SizedBox(height: 30),
              // Subheading Section
              Row(
                children: [
                  const Text(
                    "Your Program",
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(96, 245, 241, 241), fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  const Text(
                    "Details",
                    style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward, size: 20, color: Colors.blueAccent),
                ],
              ),
              const SizedBox(height: 20),
              // Next Workout Section
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade300, Colors.blue.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(95),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 10),
                      blurRadius: 30,
                      color: Colors.black26.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Next Workout",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Legs Toning\nand Glutes Workout",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 25, color: Colors.white),
                              SizedBox(width: 10),
                              Text("60 min", style: TextStyle(fontSize: 20, color: Colors.white)),
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.play_circle_fill, color: Colors.white, size: size.height * 0.08),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Features Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildFeatureButton(
                      context,
                      icon: Icons.bluetooth,
                      label: 'Connect',
                      color: Colors.blue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Connectionscreen())),
                    ),
                    buildFeatureButton(
                      context,
                      icon: Icons.settings,
                      label: 'Control Panel',
                      color: Colors.green,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ControlPanelScreen())),
                    ),
                    buildFeatureButton(
                      context,
                      icon: Icons.music_note_outlined,
                      label: 'Music',
                      color: Colors.orange,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MusicControlWidget())),
                    ),

                    buildFeatureButton(
                      context,
                      icon: Icons.download_for_offline_outlined,
                      label: 'OTA',
                      color: Colors.red,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OTAUpdateWidget())),
                    ),
                    buildFeatureButton(
                      context,
                      icon: Icons.stacked_bar_chart_outlined,
                      label: 'Streak',
                      color: const Color.fromARGB(255, 134, 6, 254),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StreakApp())),
                    ),



                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Area of Focus Section
              const Text(
                "Area of Focus",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 255, 255, 255)),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (info.length / 2).ceil(),
                itemBuilder: (context, i) {
                  int a = 2 * i;
                  int b = a + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: FocusCard(info: info[a]),
                        ),
                        if (b < info.length) const SizedBox(width: 15),
                        if (b < info.length)
                          Expanded(
                            child: FocusCard(info: info[b]),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FocusCard extends StatelessWidget {
  final Map<String, String> info;

  const FocusCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(info['image']!), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(blurRadius: 3, offset: Offset(5, 5), color: Colors.black26.withOpacity(0.1)),
          BoxShadow(blurRadius: 3, offset: Offset(-5, -5), color: Colors.black26.withOpacity(0.1)),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        info['title']!,
        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
