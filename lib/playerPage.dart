import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/PlayerPage1.dart';
import 'package:music_player/SongsMetadata.dart';
import 'marquee.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audiotagger/audiotagger.dart';


class PlayerPage extends StatefulWidget {
  var name;
  var artist;
  var album;
  var artWork;
  var path;
  PlayerPage({Key key, this.album, this.artWork, this.artist, this.name, this.path}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState( name, artist, album, artWork, path );
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {




 String name1, artist1, album1, path1;
var artWork1 ;
String name =
 "Play a Song",
      artist = "Artist",
     
      album = "Song Album";
      var artWork = null;

_PlayerPageState( this.name1 , this.artist1, this.album1, this.artWork1, this.path1);
 




  var _pageController;


  

  List<SongInfo> songs;

  AudioPlayer audioPlayer = new AudioPlayer();
  bool isPlaying = false;
  int audioStatus = 0;

  var sliderPosition = 0.0;

  var _position = Duration();
  var _duration = Duration();
var tagger = new Audiotagger();
  var sliderValue = 0.0;
  var gradientColors = [
    Colors.red.withOpacity(0.4),
    Color.fromRGBO(0, 27, 58, 1),
  ];
  AnimationController iconAnimationController;

  var icon = AnimatedIcons.play_pause;
  var index = Random().nextInt(6) + 1;

  
 FlutterAudioQuery audioQuery = new FlutterAudioQuery();

  @override
  void initState() {
   
    super.initState();
    name = (name1 != null)? name1 : name;
    artist = (artist1 != null)? artist1 : artist;
    album = (album1 != null)? album1 : album;
    artWork = (artWork1 != null) ? artWork1 : artWork;
    _pageController = PageController(
      initialPage: 0
    );
    iconAnimationController = (isPlaying)? AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    ).forward():
    AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
   
     //  iconAnimationController.forward();
    startPlayer(path1);
    initPlayer();

  }


  void startPlayer(String pathOfSong) async{
     if (pathOfSong != null) {
    int tstatus = await  audioPlayer.play(
       path1
          );
         setState(() {
            isPlaying = true;
            audioStatus = tstatus;
         });
          iconAnimationController.forward();
          }
  }

  void initPlayer() {
    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
          sliderPosition = p.inMilliseconds.toDouble();
        });
    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });
    audioPlayer.onPlayerCompletion.listen((event) {
      iconAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    iconAnimationController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color.fromRGBO(0, 27, 58, 1),
       
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
                  children: <Widget>[ SafeArea(
            child: 
          
                      Stack(
                        children: <Widget>[
                          //the background dark city image
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      (MediaQuery.of(context).size.height * 60) /
                                          100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: 
                                          ( artWork == null)?
                                           AssetImage(
                                            "images/number0.jpg",
                                          ): 
                                          MemoryImage(
                                          
                                          artWork
                                       
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  height:
                                      (MediaQuery.of(context).size.height * 60) /
                                          100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Color.fromRGBO(0, 27, 58, 0.2),
                                        Color.fromRGBO(0, 27, 58, 1)
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                ),
                              ],
                            ),
                          ),

                          // content of the like slider and buttons
                          Column(
                            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  CircleAvatar(
                                      backgroundColor:
                                          // Colors.black.withOpacity(0.2),
                                          Color.fromRGBO(0, 27, 58, 0.2),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.grey[300],
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              MediaQuery.of(context).size.height *
                                                  0.04),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "ALBUM",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w700,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                letterSpacing: 1.5),
                                          ),
                                          Padding(
                                            padding:
                                                //  EdgeInsets.only(),
                                                EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                            child: Text(
                                              (album==null || album == "" || album == " ")? "[Not Available]":
                                              (album.length >32)?
                                              album.substring(0, 30)+"..":
                                              album,
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                      backgroundColor:
                                          //  Colors.black.withOpacity(0.2),
                                          Color.fromRGBO(0, 27, 58, 0.2),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () async {
                                          String path =
                                              await FilePicker.getFilePath();
                                          // FutureBuilder checker = FutureBuilder(
                                          //   future: getAllTheAlbumsData(),
                                          //   builder: (context, snapshot) {
                                          //     for (var i in snapshot.data) {
                                          //       if (i.path == path) {
                                          //         setState(() {
                                          //           name = i.name;
                                          //           artist = i.artist;
                                          //           album = i.album;
                                          //         });
                                          //       }
                                          //     }
                                          //   },
                                          // );
                                    //       File file = await FilePicker.getFile();
                                    //       TagProcessor tp = new TagProcessor();
                                    //      // File file =await new File(path);
                                    //  return tp.getTagsFromByteArray(file.readAsBytes()).then((value) => value.forEach((element) {
                                    //          debugPrint("output starts from here");
                                    //          debugPrint(element.toString());
                                    //        //  return element.toString();
                                    //        }));
                                        //   List <SongInfo> songInfo = await audioQuery.getSongs();
                                        //    setState(() {
                                        //      name = "i am a bitch i am a boss";
                                        //    });
                                        //  for(var i in songInfo) {
                                        //     debugPrint("there are file paths");
                                        //         debugPrint(path);
                                        //          debugPrint(i.filePath);
                                        //       if (path == i.filePath){
                                              
                                        //         setState(() {
                                        //           name = i.displayName;
                                        //           artist= i.artist;
                                        //           album= i.album;
                                        //         });
                                        //       }
                                        //    }

                                          //  songs.add();
                                          
                                          Map map = await tagger.readTagsAsMap(path: path);
                                          var bytes = await tagger.readArtwork(path: path);
                                          setState(() {
                                            name = map['title'];
                                            artist = map['artist'];
                                            album = map['album'];
                                            artWork = bytes;
                                            // debugPrint("this is going to be the artwork");
                                            // debugPrint(artWork);
                                          });
                                          if (path != null) {
                                         //   checker;
                                            int status = await audioPlayer
                                                .play(path, isLocal: true);

                                            if (status == 1) {
                                              setState(() {
                                                isPlaying = true;
                                                audioStatus = status;
                                              });
                                              iconAnimationController.forward();
                                            } else {}
                                            // else {
                                            //   audioPlayer.stop();
                                            //  setState(() {
                                            //    isPlaying = false;
                                            //  });
                                            //   iconAnimationController.reverse();
                                            // }
                                          }
                                        },
                                      )),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.02,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.36,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // Expanded(child: Container(),),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.06,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.05,
                                          child: Marquee(
                                            text:
                                            (name == null || name == "" || name == " ")? "The title for this music is not available":
                                             name,
                                            textStyle: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.07,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                letterSpacing: 1),
                                            scrollAxis: Axis.horizontal,
                                          ),
                                        ),
                                      ),
                                      //   Expanded(child: Container(),),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.06,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Text(
                                        (artist==null || artist == "" || artist == " ")? "[Not Available]":
                                        (artist.length > 44)?
                                        artist.substring(0,44)+"...":
                                        artist,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              // fontWeight: FontWeight.w600,
                                              color: Colors.grey)),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.013,
                              ),
                              //Slider widget
                              Slider(
                                value: sliderPosition,
                                //_position.inMilliseconds.toDouble(),

                                onChanged: (value) async {
                                  setState(() {
                                    sliderPosition = value;
                                  });

                                  await audioPlayer.seek(
                                      Duration(milliseconds: value.toInt()));
                                },
                                min: 0.0,

                                max: _duration.inMilliseconds.toDouble(),

                                activeColor: Colors.pink[300],
                              ),

                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.065,
                                  ),
                                  Text(
                                    // currentTime,
                                    _position
                                        .toString()
                                        .split('.')[0]
                                        .substring(2),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    // completeTime,
                                    _duration
                                        .toString()
                                        .split('.')[0]
                                        .substring(2),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.065,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.013,
                              ),
                              // Pause, play and rewind buttons
                              Container(
                                margin: EdgeInsets.only(
                                    //    top: MediaQuery.of(context).size.height*0.2
                                    ),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.1,
                                    ),
                                    Expanded(
                                        child: Icon(
                                      Icons.fast_rewind,
                                      size: MediaQuery.of(context).size.width *
                                          0.11,
                                      color: Colors.grey[400],
                                    )),
                                    // SizedBox(width: MediaQuery.of(context).size.width*.029,),

                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          CircleAvatar(
                                              radius: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      10) /
                                                  100,
                                              backgroundColor: Colors.pink[300],
                                              child: GestureDetector(
                                                onTap: () async {
                                                  // if (iconAnimationController
                                                  //     .isCompleted) {
                                                  //   iconAnimationController
                                                  //       .reverse();
                                                  // } else {
                                                  //   iconAnimationController
                                                  //       .forward();
                                                  // }

                                                  if (isPlaying == false &&
                                                      audioStatus == 1) {
                                                    iconAnimationController
                                                        .forward();
                                                    await audioPlayer.resume();
                                                    setState(() {
                                                      isPlaying = true;
                                                    });
                                                  } else {
                                                    if (isPlaying == true) {
                                                      iconAnimationController
                                                          .reverse();
                                                      await audioPlayer.pause();
                                                      setState(() {
                                                        isPlaying = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: AnimatedIcon(
                                                  icon: icon,
                                                  progress:
                                                      (iconAnimationController ==
                                                              null)
                                                          ? Container()
                                                          : iconAnimationController,
                                                  //  (!this.iconAnimationController?.value?.initialized ?? false) ? new Container() : iconAnimationController ,
                                                  // iconAnimationController,

                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.18,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    //  SizedBox(width: MediaQuery.of(context).size.width*.029,),

                                    Expanded(
                                        child: Icon(
                                      Icons.fast_forward,
                                      size: MediaQuery.of(context).size.width *
                                          0.11,
                                      color: Colors.grey[400],
                                    )),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * .1,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.12,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    // top: MediaQuery.of(context).size.height*0.59
                                    ),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * .06,
                                    ),
                                    Expanded(
                                        child: Icon(
                                      Icons.bookmark_border,
                                      color: Colors.pink[300],
                                    )),
                                    Expanded(
                                        child: Icon(
                                      Icons.shuffle,
                                      color: Colors.pink[300],
                                    )),
                                    Expanded(
                                        child: Icon(
                                      Icons.repeat,
                                      color: Colors.pink[300],
                                    )),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * .06,
                                    ),
                                  ],
                                ),
                             
                              ),
                        ],
                      ),
                        ]
          ),
    ),
        PlayerPage11(), 
      // collectionMethod(context),         
                   ]
                    ),
    );

              // the lower portion which comes when scroll
            
  
  }
}
