// ignore_for_file: file_names

import 'dart:convert';//imports for encripting
import 'package:crypto/crypto.dart';

import 'package:prueba_tecnica/configurations/Firebase.dart';//import for getting credentials

import 'package:shared_preferences/shared_preferences.dart';//import for local store


Future rememberPasswordOnLocal()async{
  final preferences=await SharedPreferences.getInstance();
  await preferences.setString('remember', 'true');
}
Future<bool> rememberedOnLocal()async{
  final preferences=await SharedPreferences.getInstance();
  final String? remember=preferences.getString('remember');
  if(remember==null){
    return false;
  }else{return true;}
}
Future deleteLocalPersistence()async{
  final preferences=await SharedPreferences.getInstance();
  preferences.remove('remember');
}

Future saveLoginCredentials(String phoneNumber)async{
  final preferences=await SharedPreferences.getInstance();
  await preferences.setString('phoneNumber', encryptingSHA256(phoneNumber));
}
Future deleteLoginCredentials()async{
  final preferences=await SharedPreferences.getInstance();
  preferences.remove('phoneNumber');
}
Future<bool> hasCredentials() async {
  final preferences=await SharedPreferences.getInstance();
  final String? phoneNumber=preferences.getString('phoneNumber');
  if(phoneNumber==null){
    return false;
  }else{return true;}
}
Future<String?> getLoginCredentials()async{
  final preferences=await SharedPreferences.getInstance();
  final String? phoneNumber=preferences.getString('phoneNumber');
  return phoneNumber;
}

percentage(double input, int percentage){//calculates percentages
  return (input/100)*percentage;
}

encryptingSHA256(String input){
  var bytes = utf8.encode(input); // data being hashed

  var digest = sha256.convert(bytes);
  
  return digest.toString();
}

Future<bool> validations(String phoneNumber, String password) async {
  List credentials=await getLoginCollection();
  for (var credential in credentials) {
    if(encryptingSHA256(phoneNumber)==credential['Number']){
      if(encryptingSHA256(password)==credential['Password']){
        return true;
      }
    }
  }
  return false;
}