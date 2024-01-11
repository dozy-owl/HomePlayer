import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlayerApp());
}

class PlayerApp extends StatelessWidget {
  const PlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(100, 187, 119, 8)),
        useMaterial3: true,
      ),
      home: const PlayerHomePage(title: 'Player'),
    );
  }
}

class PlayerHomePage extends StatefulWidget {
  const PlayerHomePage({super.key, required this.title});

  final String title;

  @override
  State<PlayerHomePage> createState() => _HomePageMusicState();
}


class _HomePageMusicState extends State<PlayerHomePage> with TickerProviderStateMixin {
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  Map tracks = {
    0: {
      "name" : "Control",
      "author" : "Halsey",
      "album" : "None",
      "path" : "assets/songs/1.mp3",
      "pict" : "assets/img/2.jpg",
    },
    1: {
      "name" : "None",
      "author" : "None",
      "album" : "None",
      "path" : "assets/songs/2.mp3",
      "pict" : "assets/img/2.jpg",
    },
  };

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  playAudioFile() async {
    await audioPlayer.setAsset('assets/songs/1.mp3');
    audioPlayer.play();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                await playAudioFile();
                setState(() {
                  isPlaying = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tap to play',

                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (audioPlayer.playing) {
                  audioPlayer.pause();

                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  audioPlayer.play();
                  setState(() {
                    isPlaying = true;
                  });
                }
              },
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_arrow_outlined,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}