import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  final String name;
  final String info;
  const ProfileInfo({Key? key, required this.name, required this.info}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}