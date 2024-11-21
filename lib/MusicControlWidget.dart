import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

class MusicControlWidget extends StatefulWidget {
  const MusicControlWidget({super.key});

  @override
  _MusicControlWidgetState createState() => _MusicControlWidgetState();
}

class _MusicControlWidgetState extends State<MusicControlWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlayingBreathing = false;
  bool isPlayingOcean = false;
  bool isPlayingAmbient = false;
  bool isPlayingCustom = false;
  String? customMusicPath;
  String customMusicName = '';
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final String breathingUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  final String oceanUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
  final String ambientUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3';

  void _toggleMusic(String soundType, bool isOn) async {
    await _audioPlayer.stop(); // Stop any currently playing music
    setState(() {
      isPlayingBreathing = false;
      isPlayingOcean = false;
      isPlayingAmbient = false;
      isPlayingCustom = false;
      customMusicName = '';
    });

    if (isOn) {
      try {
        if (soundType == 'breathing') {
          await _audioPlayer.play(UrlSource(breathingUrl));
          setState(() => isPlayingBreathing = true);
        } else if (soundType == 'ocean') {
          await _audioPlayer.play(UrlSource(oceanUrl));
          setState(() => isPlayingOcean = true);
        } else if (soundType == 'ambient') {
          await _audioPlayer.play(UrlSource(ambientUrl));
          setState(() => isPlayingAmbient = true);
        }
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  Future<void> _pickCustomMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        customMusicPath = result.files.single.path;
        customMusicName = result.files.single.name;
      });

      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(DeviceFileSource(customMusicPath!));
        setState(() => isPlayingCustom = true);
        
        // Listen to position and duration changes
        _audioPlayer.onDurationChanged.listen((d) {
          setState(() {
            _duration = d;
          });
        });

        _audioPlayer.onPositionChanged.listen((p) {
          setState(() {
            _position = p;
          });
        });

      } catch (e) {
        print("Error playing custom music: $e");
      }
    } else {
      print("No file selected or invalid file.");
    }
  }

  void _stopCustomMusic() async {
    await _audioPlayer.stop();
    setState(() {
      isPlayingCustom = false;
      _position = Duration.zero;
    });
  }

  void _seekTo(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  Widget _buildSoundTile({
    required String title,
    required IconData icon,
    required Color color,
    required bool isPlaying,
    required ValueChanged<bool> onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPlaying ? color.withOpacity(0.2) : Colors.white,
        border: Border.all(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Switch(
            value: isPlaying,
            onChanged: onToggle,
            activeColor: color,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMusicTile() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.2),
        border: Border.all(color: Colors.purple, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.library_music, color: Colors.purple, size: 30),
              SizedBox(width: 10),
              Text(
                "Custom Music",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.folder_open, color: Colors.purple, size: 30),
            onPressed: _pickCustomMusic,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomMusicControls() {
    return Visibility(
      visible: isPlayingCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing: $customMusicName',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: _position.inSeconds.toDouble(),
            min: 0.0,
            max: _duration.inSeconds.toDouble(),
            onChanged: _seekTo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.stop, color: Colors.red),
                onPressed: _stopCustomMusic,
              ),
              IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.green),
                onPressed: () => _audioPlayer.resume(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yoga Music & Sounds",
          style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 253, 250, 250)),
        ),
        backgroundColor: const Color.fromARGB(255, 165, 1, 253),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Relaxing Sounds",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSoundTile(
              title: "Breathing Exercise",
              icon: Icons.self_improvement,
              color: Colors.blue,
              isPlaying: isPlayingBreathing,
              onToggle: (isOn) => _toggleMusic('breathing', isOn),
            ),
            _buildSoundTile(
              title: "Ocean Waves",
              icon: Icons.water,
              color: Colors.teal,
              isPlaying: isPlayingOcean,
              onToggle: (isOn) => _toggleMusic('ocean', isOn),
            ),
            _buildSoundTile(
              title: "Ambient Music",
              icon: Icons.music_note,
              color: Colors.green,
              isPlaying: isPlayingAmbient,
              onToggle: (isOn) => _toggleMusic('ambient', isOn),
            ),
            _buildCustomMusicTile(),
            const SizedBox(height: 20),
            _buildCustomMusicControls(), // Display the custom music controls
          ],
        ),
      ),
    );
  }
}
