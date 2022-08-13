// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';//import for the device orientation

import 'package:prueba_tecnica/components/Colors.dart';//imports for the components

import 'package:prueba_tecnica/configurations/LocalStore.dart';//import for local storage and configurations

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late double height,width;//dimensions of the device

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([//controlling the device orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        child: layout(),
      )
    );
  }

  layout(){
    return Stack(
      children: [
        tray(percentage(height, 20)),
        userProfile(percentage(height, 5),'Sidhar Araujo','Barranquilla, Atlantico')
      ],
    );
  }

  
  tray(double size){
    return Positioned(
      top: 0,
      child: Container(
        alignment: Alignment.center,
        height: size,
        width: width,
        decoration: 
          BoxDecoration(
            color: AppColor.green
          ),
      ),
    );
  }

  userProfile(double distanceFromTop, String Name, String info){
    return Positioned(
      child: Row(
        
      )
    );
  }
}