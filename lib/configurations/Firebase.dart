// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

getLoginCollection() async {
  CollectionReference loginInfo=FirebaseFirestore.instance.collection('Login');
    QuerySnapshot snapshot = await loginInfo.get();
    List allCredentials = snapshot.docs.map((doc) => doc.data()).toList();
    return allCredentials;
}

initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}