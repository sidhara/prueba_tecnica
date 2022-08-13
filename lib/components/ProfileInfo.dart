// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/configurations/Firebase.dart';
import 'package:prueba_tecnica/configurations/LocalStore.dart';

class ProfileInfo extends StatefulWidget {
  final String phoneNumber;
  const ProfileInfo({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

late double height,width;//dimensions of the device

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context){
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Row(
      children: [
        FutureBuilder(//image
          future: getImageUrl('${widget.phoneNumber}.jpg'),
          builder: (BuildContext context, AsyncSnapshot<String>snapshot){
            if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
              return CircleAvatar(
                radius: percentage(height, 6),
                backgroundImage: NetworkImage(snapshot.data!),
              );
            }
            if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
              return const CircularProgressIndicator();
            }
            return Container();
          }
        ),
        const SizedBox(//space between elements
          width: 10,
        ),
        Container(
          width: percentage(width, 52),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(//name
              future: getUserName(widget.phoneNumber),
              builder: (BuildContext context, AsyncSnapshot<String>snapshot){
                if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white
                    ),
                  );
                }
                if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
                  return const CircularProgressIndicator();
                }
                return Container();
              }
            ),
            const SizedBox(//space between elements
              height: 5,
            ),
            FutureBuilder(//info
              future: getUserInfo(widget.phoneNumber),
              builder: (BuildContext context, AsyncSnapshot<String>snapshot){
                if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white
                    ),
                  );
                }
                if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
                  return const CircularProgressIndicator();
                }
                return Container();
              }
            ),
          ],
        ),
        )
      ],
    );
  }
}