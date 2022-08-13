// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prueba_tecnica/components/Colors.dart';//imports for components
import 'package:prueba_tecnica/components/ProfileInfo.dart';
import 'package:prueba_tecnica/configurations/Firebase.dart';
import 'package:prueba_tecnica/configurations/LocalStore.dart';

import 'package:prueba_tecnica/frames/Login.dart';//import for navigation

class NavBar extends StatefulWidget {
  final String phoneNumber;
  const NavBar({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int index=1;//put this out
  final pages=[
    Container(),
    Container(//home
      width: width,
      height: percentage(height, 70),
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
    FutureBuilder(
      future: getRoutes(),
      builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot){
        if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
          print(snapshot.data!);
        }
        if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        return Container();
      },
    )
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(//decorations
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.green,
      )
    );
    return Column(
      children: [
        pages[5],
        Container(//Nav Bar
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: AppColor.green,
                  width: 4,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) async {
              if(index==4){
                deleteLoginCredentials();
                await showDialog(
                  context: context,
                  builder: (context){
                    return const AlertDialog(
                      title: Text('Credential reset'),
                      content: Text('Please login again!'),
                    );
                  }
                );
                Navigator.pushAndRemoveUntil(//navigation to Login
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false
                );   
              }
              setState(() {
                this.index=index;
              });
            },
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
          )   
        )
      ]
    );
  }
}