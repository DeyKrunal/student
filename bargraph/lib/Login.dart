import 'dart:convert';
import 'dart:ui';

import 'package:bargraph/ChartPage.dart';
import 'package:bargraph/HomePage.dart';
import 'package:bargraph/main1.dart';
import 'package:bargraph/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'splash.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // This sets the splash screen as the home screen
      // Set other configurations for your app here
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _passwordVisible = true;
  // final call_api api = call_api();

  late RiveAnimationController _btnAnimationController;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isShowSignInDialog = false;
  bool _wrongPass = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery
                .of(context)
                .size
                .width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.fromLTRB(20,20,250,0),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child:FloatingActionButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const OnbodingScreen()));
                          },
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50), // Adjust radius as needed
                            ),
                          child:const Icon(Icons.arrow_back,color: Colors.black,)                          ),
                                          ),
                            ),
                    const SizedBox(height: 50),
                    const Padding(padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Center(
                    //   child:
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.group,color: Colors.black,),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius
                                            .circular(30)
                                    ),
                                    labelText: "Group Id",
                                    hintText: "Enter Group Id",
                                  ),
                                   validator: (msg){
                                    if(msg!.isEmpty){
                                      return "Group Id is Required";
                                    }
                                    return null;
                                   },
                                ),
                              ),
                              Padding(padding: const EdgeInsets.fromLTRB(
                                  5, 20, 5, 5),
                                child: TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText:_passwordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,color: Colors.black),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black
                                        ),
                                        borderRadius: BorderRadius
                                            .circular(30)
                                    ),
                                    labelText: "Password",
                                    hintText: "Enter Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,color: Colors.white,),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (msg){
                                    if(msg!.isEmpty){
                                      return "password is Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(padding: const EdgeInsets.fromLTRB(150,0,0,20),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot Password?',style: TextStyle(color: Colors.black,fontSize: 15)),
                                ),

                              ),
                              SizedBox(height: 50, width: 150,
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var name = _nameController.text;
                                      var pwd = _passwordController.text;
                                        await _saveData(name, pwd)
                                          .then((value) {
                                        print("value: ${value}");
                                        print("value: ${value.runtimeType}");
                                        if (value == "2") {
                                          setState(() {
                                            _wrongPass = true;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigationDemo(),
                                                ));
                                          });
                                        } else {
                                          setState(() {
                                            _wrongPass = false;
                                          });
                                          Constants.prefs!.setBool("isLogin", true);

                                          print("** login s:${Constants.prefs?.getBool("isLogin")}");
                                        }
                                      });
                                    }
                                  },
                                  child: const Text('Login',
                                      style: TextStyle(fontSize: 20,)
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void saveData(key,value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    // You can also save other data types like int, double, bool, etc.
  }
  void saveData1(key,value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    // You can also save other data types like int, double, bool, etc.
  }


  Future<String> _saveData(String name,String pwd) async {
      var res = await http.post(
          Uri.parse("https://project-pilot.000webhostapp.com/API/login_api.php"),
          body: {"name": "$name", "pwd": "$pwd"});
      print("res: ${res.body}");
      print('Data saved');
      print("Name = $name");
      print("Password = $pwd");

      var finalRespoanse = jsonDecode(res.body);
      if (finalRespoanse["success"] == 2) {
        var x1 = finalRespoanse["fid"];
        var x2 = finalRespoanse["gid"];
        print("Hello = ${x2}");
        saveData("gid", x2);
        saveData("fid", x1);
        saveData1("login", true);
      }else{
        saveData("gid", "");
        saveData("fid", "");
        // await  Constants.prefs?.setString("gid", "");
        // await  Constants.prefs?.setString("fid", "");
      }
      // print("Group = ${Constants.prefs?.getString("gid")}");
      // print("Group = ${prefs1?.getString("gid")}");
      return finalRespoanse["success"].toString();

      // Constants.prefs!.setString('Name = $name', 'Password = $pwd');

    }
}