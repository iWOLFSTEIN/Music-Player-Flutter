
import 'package:audiotagger/audiotagger.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/playerPage.dart';
import 'dart:io';

import 'SongsMetadata.dart';




class PlayerPage11 extends StatefulWidget {
  PlayerPage11({Key key}) : super(key: key);

  @override
  _PlayerPage11State createState() => _PlayerPage11State();
}

class _PlayerPage11State extends State<PlayerPage11> with SingleTickerProviderStateMixin{

 var imageList = [
    'images/number1.jpg',
    'images/number2.jpg',
    'images/number3.jpg',
    'images/number4.jpg',
    'images/number5.jpg',
    'images/number6.jpg',
  ];
var tagger =  Audiotagger();
//TabController _tabController ;

// var someVariable = null;

var audioQuery = FlutterAudioQuery();

  getAllTheAlbumsData() async{
    List<SongInfo> albumList = await audioQuery.getSongs();
    
   
    List fileData = [];
    
    
    for (var i in albumList) {
     // debugPrint(i.toString());
      var time = DateTime.fromMillisecondsSinceEpoch(int.parse(i.duration)).toString().split(' ')[1];
      var time1 = time.split(':');
      var time2 = time1[1] + ":" +time1[2].split('.')[0];
     //   Map map = await tagger.readTagsAsMap(path: i.filePath);
       var bytes = await tagger.readArtwork(path: i.filePath);
     // var time = DateTime(time1.minute, time1.second).toString();
      fileData.add(MetaDataOfSongs(
          name: i.displayName,
        //   map['title'],
           artist: i.artist,
            album: i.album,
          path: i.filePath,
          albumArt: bytes,
          size: time2,
          ));
          
      // myFiles.add(File(i.albumArt.toString()));

    }


   
    return
    
    fileData;
  }


  collectionMethod(context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 27, 58, 1),
     
          body: 
          
                        SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                  child: Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(0, 27, 58, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // first child of the column
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02),

                      // Container that contains the search text field and search icons
                      child: Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.015,
                            right: MediaQuery.of(context).size.width * 0.015),
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(10))),

                        // Row of widgets containing search icons and text field
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.015,
                                  right: MediaQuery.of(context).size.width * 0.015),

                              // the search text field
                              child: TextField(
                                autocorrect: false,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  letterSpacing: 1,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search music ...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.6),
                                      fontSize:
                                          MediaQuery.of(context).size.width * 0.04,
                                      letterSpacing: 1,
                                    )),
                              ),
                            )),
                            Icon(
                              Icons.mic,
                              color: Colors.white.withOpacity(0.8),
                            )
                          ],
                        ),
                      ),
                    ),

                    // Second child of the column
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Playlists",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.075,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    CarouselSlider(
                        items: imageList.map((f) {
                          return Container(
                              //    height: MediaQuery.of(context).size.height*0.1,
                              width: MediaQuery.of(context).size.width * 0.77,
                              //  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),

                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(f, fit: BoxFit.cover)));
                        }).toList(),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.28,

                          //    aspectRatio: 16/9,
                          //   autoPlay: true,
                          enlargeCenterPage: true,
                          initialPage: 0,
                        )),

                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Songs",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),

                    Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                      
                        child: FutureBuilder(
                            //  initialData: ["Loading ..."],
                            future: getAllTheAlbumsData(),
                            builder: (context, snapshot) {
                              
                              if (snapshot.hasData
                            //   && snapshot.connectionState == ConnectionState.done
                               ) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {


                                      return ListTile(
                                       
                                         leading:
                                        Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  1,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.14,
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child:
                                        (snapshot.data[index].albumArt == null)
                                                ? 
                                                Image.asset("images/music.png",
                                                    fit: BoxFit.cover)
                                                    : Image.memory(snapshot.data[index].albumArt,
                                                    fit: BoxFit.cover),
                                       
                                          ),
                                        ),
                                        title: Text(
                                          // snapshot.data.map <String>((f){
                                          // return f.name;
                                          // }),
                                          snapshot.data[index].name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          snapshot.data[index].size,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                         onTap: (){
                                           debugPrint("A button is pressed");
                                       Navigator.push(context, MaterialPageRoute(builder: (context){
                                         return PlayerPage(
                                         name:  snapshot.data[index].name,
                                         album: snapshot.data[index].album,
                                         artist: snapshot.data[index].artist,
                                         artWork: snapshot.data[index].albumArt,
                                         path:  snapshot.data[index].path,
                                         );
                                       }));
                                        },
                                        // title: Text(snapshot.data[index]),
                                      );
                                    });
                              }
                              else {
                                return Center(
                                    child: Padding(
                                  
                                   padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                                    child: CircularProgressIndicator()),
                                );
                              }
                            }))
                  ],
                ),
              ),
          ),
        ),
      ),
                    
    );

}
  @override
  Widget build(BuildContext context) {
    return collectionMethod(context);
  }

 

}
  