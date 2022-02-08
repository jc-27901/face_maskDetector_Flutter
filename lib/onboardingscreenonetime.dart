import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return HomeScreen.id;
    } else {
      // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
     await prefs.setBool('seen', true);
      return IntroScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MaterialApp(
              initialRoute: snapshot.data,
              routes: {
                IntroScreen.id: (context) => IntroScreen(),
                HomeScreen.id: (context) => HomeScreen(),
              },
            );
          }
        });
  }





  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}

class HomeScreen extends StatelessWidget {
  static String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Hello'),
      ),
      body: new Center(
        child: GestureDetector(onTap:() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
       //   prefs.setBool('seen', false);
        },child: new Text('This is the second page')),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  static String id = 'IntroScreen';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('IntroScreen'),
      ),
      body: new Center(
        child: GestureDetector(onTap: ()async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
       //  prefs.setBool('seen', true);
        },child: new Text('This is the IntroScreen')),
      ),
    );
  }
}
