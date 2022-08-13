// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prueba_tecnica/components/Colors.dart';
import 'package:prueba_tecnica/components/ProfileInfo.dart';
import 'package:prueba_tecnica/configurations/LocalStore.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index=1;
  final pages=[
    Container(),
    Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: const Text(
          'Welcome to DashFleet business!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
        ),),

    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(//decorations
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.greenAccent,
      )
    );
      
    return Column(
      children: [
        pages[index],
        NavigationBar(//this has to be a stack
          selectedIndex: index,
          onDestinationSelected: (index)=>setState(() {
            this.index=index;
          }),
          destinations: [ 
            NavigationDestination(
              icon: const Icon(Icons.add),
              selectedIcon: Icon(Icons.add,color: AppColor.green,),
              label: '',
            ),
            NavigationDestination(
              icon: const Icon(Icons.home),
              selectedIcon: Icon(Icons.home,color: AppColor.green,),
              label: '',
            ),
            NavigationDestination(
              icon: const Icon(Icons.wallet),
              selectedIcon: Icon(Icons.wallet,color: AppColor.green,),
              label: '',
            ),
            NavigationDestination(
              icon: const Icon(Icons.attach_money_outlined),
              selectedIcon: Icon(Icons.attach_money_outlined,color: AppColor.green,),
              label: '',
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              selectedIcon: Icon(Icons.settings,color: AppColor.green,),
              label: '',
            ),
          ]
        ),
        
      ]
    );
  }
}