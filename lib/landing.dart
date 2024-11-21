import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/pages/HomePage.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Colors.blue.shade100], // Soft gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.only(top: 40.0, left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: Image.network(
                  "https://studio.code.org/v3/assets/rkFLVPs0l8fowTp2STej47105shewzrBtgoTHX_yNiA/Ladymeditating.gif",
                 
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              "Smart Yoga Mat",
              style: TextStyle(
                color: Color.fromARGB(255, 34, 33, 33), // White text for contrast on dark background
                fontSize: 34.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Your Personalized Yoga Assistant",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), // Lighter white for the subtitle
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 90.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 15.0, bottom: 15.0, right: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFCC3f), // Golden button color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20.0),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
