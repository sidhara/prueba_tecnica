// ignore_for_file: file_names

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prueba_tecnica/configurations/LocalStore.dart';

Future<String>getImageUrl(String fileName)async{
  FirebaseStorage storage=FirebaseStorage.instance;
  String url=await storage.ref('users/$fileName').getDownloadURL();
  return url;
}

getLoginCollection()async{
  CollectionReference loginInfo=FirebaseFirestore.instance.collection('Login');
    QuerySnapshot snapshot = await loginInfo.get();
    List allCredentials = snapshot.docs.map((doc) => doc.data()).toList();
    return allCredentials;
}

Future<String>getUserName(String phoneNumber)async{
  CollectionReference userName=FirebaseFirestore.instance.collection('UsersInfo');
  QuerySnapshot snapshot = await userName.get();
  List users = snapshot.docs.map((doc) => doc.data()).toList();
  String name='';
    for(var user in users){
      if(user['Number']==phoneNumber){
        name=user['Name'];
      } 
    }
  return name;
}
Future<String>getUserInfo(String phoneNumber)async{
  CollectionReference userInfo=FirebaseFirestore.instance.collection('UsersInfo');
  QuerySnapshot snapshot = await userInfo.get();
  List users = snapshot.docs.map((doc) => doc.data()).toList();
  String info='';
    for(var user in users){
      if(user['Number']==phoneNumber){
        info=user['Info'];
      } 
    }
  return info;
}
Future<dynamic>getRoutes()async{
  String? phoneNumber=await getLoginCredentials();
  CollectionReference routesInfo=FirebaseFirestore.instance.collection('Routes');
  QuerySnapshot snapshot = await routesInfo.get();
  List routes = snapshot.docs.map((doc) => doc.data()).toList();
  dynamic userRoute;
      for(var route in routes){
      if(route['Number']==phoneNumber){
        userRoute=route['Routes'];
      } 
    }
  return userRoute;
}

initialize()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}