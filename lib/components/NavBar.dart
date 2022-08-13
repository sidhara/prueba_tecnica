// ignore_for_file: file_names, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prueba_tecnica/components/Colors.dart';//imports for components
import 'package:prueba_tecnica/components/ProfileInfo.dart';

import 'package:prueba_tecnica/configurations/Firebase.dart';//imports for data fecht and configurations
import 'package:prueba_tecnica/configurations/LocalStore.dart';

import 'package:prueba_tecnica/frames/Login.dart';//import for navigation

class NavBar extends StatefulWidget {
  final String phoneNumber;
  const NavBar({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

int globalIndex=1,indexSupp=1;

class _NavBarState extends State<NavBar> {
  _NavBarState();

  final pages=[
    Container(),
    Container(//home page
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
    Container(
      child:FutureBuilder(//routes page
        future: getRoutes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic>snapshot){
          if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
            List routes=[];
            for(var route in snapshot.data!.toString().split(',')){
              routes.add(route.replaceAll('{','').replaceAll(' ','').replaceAll('}',''));  
            }
            int selectedIndex=0;
            return Column(
              children: [
                Container(//container route selected
                  padding: const EdgeInsets.all(20),
                  width: percentage(width, 90),
                  height: percentage(height, 15),
                  color: Colors.black26,
                  child: Row(
                    children: [
                      Icon(Icons.bus_alert,size: percentage(height, 10),),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(//route name
                            routes[selectedIndex].toString().split(':')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(//route distance
                            '${routes[selectedIndex].toString().split(':')[1]} miles',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black87
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
                SizedBox(height: percentage(height, 7),),
                Container(//container of the scroll of the routes
                  height: percentage(height, 40),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.toString().split(',').length,
                    itemBuilder: (BuildContext context, int index){
                      return Column(
                        children: [
                          GestureDetector(//container of individual route
                            onTap: ()=>{selectedIndex=index},
                            child:Container(
                              padding: const EdgeInsets.all(20),
                              width: percentage(width, 90),
                              height: percentage(height, 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.green,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.bus_alert,size: percentage(height, 10),),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(//route name
                                        routes[index].toString().split(':')[0],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black87
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(//route distance
                                        '${routes[index].toString().split(':')[1]} miles',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black87
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            )
                          ) ,
                          const SizedBox(height: 8,)
                        ],
                      );
                    }
                  ),
                )
              ]
            ); 
          }
          if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          return Container();
        },
      )
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
        pages[globalIndex],
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
            selectedIndex: indexSupp,
            onDestinationSelected: (index) async {
              if(index==4){
                deleteLoginCredentials();
                deleteLocalPersistence();
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
                indexSupp=index;
                globalIndex=index;
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