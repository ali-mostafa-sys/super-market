import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:supermarket/features/launcher/repositories/bocs/launcher_bloc.dart';
import 'package:supermarket/features/main_page/presentations/pages/main_page.dart';
import 'package:supermarket/injection_container.dart'as di;

class LauncherPage extends StatelessWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context)=>di.sl<LauncherBloc>()..add(LauncherPageEvent()),
          child: BlocConsumer<LauncherBloc,LauncherState>(
            listener: (context,state){
              if(state is LauncherState){
                Future.delayed(Duration(seconds: 3)).then((value) {
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MainPage()
                  //     ),
                  //     ModalRoute.withName("/Home")
                  // );
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => MainPage(),
                    ),
                        (route) => false,//if you want to disable back feature set to false
                  );


                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>  MainPage()),);

                });
              }
            },
            builder: (context,state){
              return WillPopScope(
                onWillPop: ()async{

                  return false;
                },
                child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: w * 0.9,
                            height: h * 0.3,

                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color:HexColor('#1d3557'),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(7, 11,)  )
                                ],
                                color: HexColor('#1d3557'),
                                borderRadius: BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Container(
                                width: w * 0.7,
                                height: h * 0.2,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color:HexColor('#457b9d'),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(7, 11,)  )
                                    ],
                                    color: HexColor('#457b9d'),
                                    borderRadius: BorderRadius.all(Radius.circular(100))),
                                child: Center(
                                  child: Container(
                                    width: w * 0.5,
                                    height: h * 0.1,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(color:HexColor('#a8dadc'),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(7, 11,)  )
                                        ],
                                        color: HexColor('#a8dadc'),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          AutoSizeText(
                                            'روجين',
                                            style: TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 10
                                                ..color = HexColor('#1d3557'),

                                            ),
                                          ),
// The text border
                                          AutoSizeText(
                                            'روجين',
                                            style: TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 2.5
                                                ..color = HexColor('#457b9d'),
//#827A39
                                            ),
                                          ),
// The text inside
                                          AutoSizeText(
                                            'روجين',
                                            style: TextStyle(
                                              letterSpacing: 1,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#F7F670'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}


