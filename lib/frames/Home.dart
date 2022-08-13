// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';//import for the device orientation

import 'package:prueba_tecnica/components/Colors.dart';//imports for the components
import 'package:prueba_tecnica/components/NavBar.dart';
import 'package:prueba_tecnica/components/ProfileInfo.dart';

import 'package:prueba_tecnica/configurations/LocalStore.dart';//import for local storage and configurations

class Home extends StatefulWidget {
  final String phoneNumber;
  const Home({Key? key, required this.phoneNumber}) : super(key: key);

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
        sideHomeMenu(percentage(height, 8)),
        userProfile(percentage(height, 5),widget.phoneNumber),
        navBar()
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

  sideHomeMenu(double distanceFromTop){
    return Positioned(
      top: distanceFromTop,
      right: percentage(width, 3),
      child: GestureDetector(
        onTap: () => onPressed(0),
        child: Icon(
        Icons.menu,
        size: percentage(width, 14),
        color: Colors.white),
      )

    );
  }

  userProfile(double distanceFromTop,String phoneNumber){
    return Positioned(
      left: percentage(width, 3),
      width: percentage(width, 81),
      top: distanceFromTop,
      child: ProfileInfo(phoneNumber: phoneNumber)
    );
  }

  navBar(){
    return Positioned(
      width: width,
      bottom: 0,
      child: const NavBar());
  }

  onPressed(int option){
    if(option==0){
      print('side menu (Rutas)');
    }
  }
}