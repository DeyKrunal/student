import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:bargraph/sign_in_form (1).dart';

import 'main1.dart';
//
// import 'components/animated_btn.dart';
// import 'components/sign_in_dialog.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

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
            width: MediaQuery.of(context).size.width * 1.7,
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      width: 350,
                      height: 70,
                      child: Padding(padding: EdgeInsets.fromLTRB(200, 20, 0, 0),
                        child: FloatingActionButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  BottomNavigationDemo()),
                            );
                          }, child: Text(" Seminar "),
                          backgroundColor: Colors.white60,

                        ),
                      ),
                    ),

                    const Spacer(),
                    const SizedBox(
                      width: 200,
                      child: Column(
                        children: [


                        ],
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      height: 125,

                      child: Padding(padding: EdgeInsets.fromLTRB(50,10, 0, 70),
                        child: FloatingActionButton(


                          onPressed: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>  SignInForm()),
                            // );
                          }, child: Text(" Sign In "),
                          backgroundColor: Colors.white60,
                        ),
                      ),
                    ),

                    SizedBox(
                     width: 280,
                     height: 125,
                     child: Padding(padding: EdgeInsets.fromLTRB(50,10, 0, 70),
                           child: FloatingActionButton(
                             onPressed: (){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) =>  BottomNavigationDemo()),
                               );
                             }, child: Text("Add Group details"),
                             backgroundColor: Colors.white60,

                           ),
                         ),
                   ),


                    // AnimatedBtn(
                    //   btnAnimationController: _btnAnimationController,
                    //   press: () {
                    //     _btnAnimationController.isActive = true;
                    //
                    //     Future.delayed(
                    //       const Duration(milliseconds: 800),
                    //           () {
                    //         setState(() {
                    //           isShowSignInDialog = true;
                    //         });
                    //         showCustomDialog(
                    //           context,
                    //           onValue: (_) {},
                    //         );
                    //         // showCustomDialog(
                    //         //   context,
                    //         //   onValue: (_) {
                    //         //     setState(() {
                    //         //       isShowSignInDialog = false;
                    //         //     });
                    //         //   },
                    //         // );
                    //       },
                    //     );
                    //   },
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 24),
                    //   child: Text(
                    //       "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates."),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
