import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(100, 187, 119, 8)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


AudioCache audioCache = AudioCache();
AudioPlayer audioPlayer = AudioPlayer();

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  int _counter = 0;

 

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
  
  int curr = -1;
  int prev = -2;
  

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        String songName = tracks[index]["name"];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CurrentSong(
                            songInfo: tracks[index],
                          )),
                        );
                      },
                      title: Text('${tracks[index]["name"]}'),
                      leading: Icon(Icons.music_note_outlined),
                      trailing: RawMaterialButton(
                        child: Icon(index == curr ? Icons.pause : Icons.play_arrow),
                        onPressed: (){
                          setState(() {
                            if (curr == index){
                              prev = index;
                              curr = -1;
                              audioPlayer.pause();
                            }
                            else if (prev == index && curr == -1){
                              audioPlayer.resume();
                              curr = index;
                            }
                            else{
                              prev = curr;
                              curr = index;
                              audioPlayer.play(DeviceFileSource("${tracks[index]["path"]}"));
                            }
                          });
                        },
                        shape: CircleBorder(),
                      ),
                      isThreeLine: false,
                    );
                  },
                ),
              ],
            ),
          ),
          /*SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tracks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(tracks[index]["pict"]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),*/
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}


class CurrentSong extends StatefulWidget {
  final Map songInfo;

  CurrentSong({required this.songInfo});

  @override
  createState() => new CurrentSongState();
}


class CurrentSongState extends State<CurrentSong> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: Column(
        children: [
          Container(
            child: Image.asset('assets/img/2.jpg'),
          ),
          Slider(
            activeColor: Colors.orange,
            inactiveColor: Colors.brown,
            value: 3,
            max: 5,
            onChanged:(value) {
              value = value; 
            },
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: RawMaterialButton(
                    onPressed: (){},
                    child: Icon(Icons.keyboard_arrow_left),
                  ),
              ),
              Flexible(
                child: RawMaterialButton(
                    onPressed: (){},
                    child: Icon(Icons.play_arrow),
                  ),
              ),
              Flexible(
                child: RawMaterialButton(
                    onPressed: (){},
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
              ),
            ]
          ),
        ], 
      ),
    );
  }
}