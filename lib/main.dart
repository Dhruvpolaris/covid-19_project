import './widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import './constant.dart';
import './widgets/counter.dart';
import './widgets/my_header.dart';

import 'package:intl/intl.dart';
import './providers/data.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: dBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: dBodyTextColor),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();
  double offset = 0;
  final String formattedDate = DateFormat.yMMMMEEEEd().format(DateTime.now());
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                children: <Widget>[
                  MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    iconleft: false,
                    textTop: "Stay Home",
                    textBottom: "Stay Safe",
                    offset: offset,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "COVID-19 Cases Overview",
                              style: dHeadingTextStyle,
                            ),
                            SizedBox(height: 3.0,),
                            Text(
                              "Updated: "+formattedDate,
                              style: TextStyle(
                                      color: dTextLightColor,
                                    ),
                            ),
                            // Spacer(),
                            // FlatButton(
                            //   onPressed: () { setState(() {
                            //     futureAlbum = fetchAlbum();
                            //   });
                            //   },
                            //   child: Text(
                            //     "Refresh",
                            //     style: TextStyle(
                            //       color: dPrimaryColor,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: dShadowColor,
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Counter(
                                    color: Colors.deepOrange.shade500,
                                    number: snapshot.data.totalConfirmed,
                                    title: "Total Confirmed",
                                  ),
                                  Spacer(),
                                  Counter(
                                    color: dInfectedColor,
                                    number: snapshot.data.newConfirmed,
                                    title: "New Confirmed",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Counter(
                                    color: Colors.red.shade900,
                                    number: snapshot.data.totalDeaths,
                                    title: "Total Deaths",
                                  ),
                                  SizedBox(width: 20.0),
                                  Counter(
                                    color: Colors.redAccent.shade400,
                                    number: snapshot.data.newDeaths,
                                    title: "New Deaths",
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Counter(
                                    color: Colors.green.shade800,
                                    number: snapshot.data.totalRecovered,
                                    title: "Total Recovered",
                                  ),
                                  Spacer(),
                                  Counter(
                                    color: dRecovercolor,
                                    number: snapshot.data.newRecovered,
                                    title: "New Recovered",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Mapping the Spread",
                              style: dTitleTextstyle,
                            ),
                            Text(
                              "View details",
                              style: TextStyle(
                                color: dPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0,bottom: 30.0),
                          padding: EdgeInsets.all(5),
                          height: 178,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 20,
                                color: dShadowColor,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/map.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                'An Error Occured!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                )
              ],
            );
            // Text(snapshot.data.title.toString()),
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Fetching Data..')
              ],
            ),
          );
        },
      ),
    );
  }
}
