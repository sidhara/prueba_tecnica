// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';//import for the device orientation

import 'package:prueba_tecnica/components/Button.dart';//imports for the components
import 'package:prueba_tecnica/components/TextField.dart';
import '../components/Colors.dart';

import 'package:prueba_tecnica/frames/Home.dart';//import for navigation

import 'package:prueba_tecnica/configurations/LocalStore.dart';//imports for local storage and configurations

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late double height,width;//dimensions of the device

  @override
  void initState(){
    skip();
    rememberPassword=false;
    super.initState();
    SystemChrome.setPreferredOrientations([//controlling the device orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);
  }

  skip()async{//I didn't enjoy doing this
    if(await hasCredentials()){
      Navigator.pushAndRemoveUntil(//navigation to home
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false
      );   
    }
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
        text('DashFleet',percentage(height, 5),30),//this can be better
        text('Login',percentage(height, 10),40),
        loginInputs(percentage(height, 25)),
        loginButton(percentage(height, 5))
      ],
    );
  }

  text(String text,double distanceFromTop,double size){
    return Positioned(
      top: distanceFromTop,
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: Colors.white
        ),
      ) 
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

  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  late bool rememberPassword;
  loginInputs(double distanceFromTop){//here is some room to upgrade
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      top: distanceFromTop,
      child: Column(
        children: [
          TextFieldCustom(
            text: 'Phone number', 
            controller: phoneNumberController, 
            password: false
          ),
          const SizedBox(//space between text fields
            height: 20,
          ),
          TextFieldCustom(
            password: true,
            controller: passwordController,
            text: 'Password',
          ),
          const SizedBox(//space between text fields
            height: 20,
          ),
          Row(
            children: [
              AnimatedContainer(//this can definitely be way better
                duration: const Duration(milliseconds: 200),
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: rememberPassword ? AppColor.green:Colors.grey.withOpacity(0.5)
                ),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      top: 3,
                      left: rememberPassword?15:0,
                      right: rememberPassword?0:15,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            rememberPassword=!rememberPassword;
                          });
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return RotationTransition(turns: animation, child: child);
                          },
                          child: rememberPassword?Icon(Icons.check_circle, key: UniqueKey(),):Icon(Icons.remove_circle_outline, key: UniqueKey(),)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(//space between elements
                width: 10,
              ),
              const Text(
                'Remember?',
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black
                ),
              ) 
            ],
          )
          
        ],
      )
    );
  }

  loginButton(double distanceFromBottom){
    return Positioned(
      width: percentage(width, 80),
      left: percentage(width, 10),
      bottom: distanceFromBottom,
      child: Column(
        children: [
          Container(
            width: percentage(width, 40),
            child: Button(
            borderRadius: 10,
            backgroundColor: Colors.black, 
            textColor: Colors.white, 
            text: "Login",
            onTap: () => onPressed(0)
            ),
          ),
          const SizedBox(//space between buttons
            height: 7,
          ),
          GestureDetector(
            onTap: () => onPressed(1),
            child: const Text(
              'Forgot your password?',
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black
              ),
            ) ,
          )
        ],
      ) 
    );
  }

  onPressed(int option) async {
    if(option==0){
      if(await validations(phoneNumberController.text,passwordController.text)){
        if(rememberPassword){
          saveLoginCredentials(phoneNumberController.text);
        }
        Navigator.pushAndRemoveUntil(//navigation to home
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false
        );   
      }else{
        passwordController.clear();
        phoneNumberController.clear();
        return showDialog(
          context: context,
          builder: (context){
            return const AlertDialog(
              title: Text('Error!'),
              content: Text('Invalid phone number or password.'),
            );
          }
        );
      }
    }else if(option==1){
      return showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            title: Text('Password recovery'),
            content: Text('we already sent a email with further instruction for password recovery.'),
          );
        }
      );
    }
  }
}