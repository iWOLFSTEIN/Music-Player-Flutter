import 'package:flutter/material.dart';
import 'package:music_player/playerPage.dart';



void main() => runApp(MyApp());


          class MyApp extends StatelessWidget {
            const MyApp({Key? key}) : super(key: key);
          
           @override
  Widget build(BuildContext context) {

 

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: 
            PlayerPage(),
           
        
                );
            }
          }
          
         