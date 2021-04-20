import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'stopwatch_screen.dart';
import 'package:in_time/utils/dependencies.dart';
import 'worldclock_screen.dart';
import 'alarm_screen.dart';
import 'bedtime_screen.dart';
import 'timer_screen.dart';
import 'package:in_time/presentation/in_time_icons_icons.dart';
import 'package:firebase/firebase.dart' as fb;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3;
  var loggedUser;
  String selectedLanguage = 'english';

  final List<Widget> pages = [
    WorldClock(key: PageStorageKey('worldclock_screen'),),
    Alarm(key: PageStorageKey('alarm_screen'),),
    BedTime(key: PageStorageKey('bedtime_screen'),),
    StopWatch(
      key: PageStorageKey('stopwatch_screen'), dependencies: Dependencies(),),
    TimerScreen(key: PageStorageKey('timer_screen'),),
  ];

  PageStorageBucket bucket = PageStorageBucket();

  String chooseMiddle(int i) {
    if (i == 0) return 'World Clock';
    if (i == 1) return 'Alarm';
    if (i == 2) return 'Bedtime';
    if (i == 3) return 'Stopwatch';
    if (i == 4)
      return 'Timer'; else
      return 'Error';
  }

  void onTapAction(int index) {
    if (index == 3) setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!fb.apps.isNotEmpty) {
      fb.initializeApp(apiKey: "AIzaSyBJSG1PRso629cmdldzBG1EbTq11fJy124",
        authDomain: "intimeapp-34ccf.firebaseapp.com",
        databaseURL: "intimeapp-34ccf.firebaseio.com",
        storageBucket: "intimeapp-34ccf.appspot.com",
        projectId: "intimeapp-34ccf",);
    }

    fb.firestore().enablePersistence();
    fb
        .auth()
        .onAuthStateChanged
        .listen((user) {
      print('success');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Color(0xFF0D0D0D),
      centerTitle: true,
      title: Text(
        chooseMiddle(_currentIndex), style: TextStyle(color: Colors.white),),),
      body: PageStorage(child: pages[_currentIndex], bucket: bucket,),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.orange,
        backgroundColor: Color(0xFF0D0D0D),
        onTap: onTapAction,
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(icon: Icon(InTimeIcons.ios_globe,
            color: _currentIndex == 0 ? Colors.orange : Color(0xFF686868),
            size: 28,),
            title: Text(
              'World Clock',
              style: TextStyle(
                  color: _currentIndex == 0 ? Colors.orange : Color(0xFF686868),
                  fontFamily: "Helvetica",
                  fontSize: 11),),),
          BottomNavigationBarItem(icon: Icon(InTimeIcons.ios_alarm,
            color: _currentIndex == 1 ? Colors.orange : Color(0xFF686868),
            size: 28,),
            title: Text(
              'Alarm',
              style: TextStyle(
                color: _currentIndex == 1 ? Colors.orange : Color(0xFF686868),
                fontFamily: "Helvetica",
                fontSize: 11,),),),
          BottomNavigationBarItem(icon: Icon(InTimeIcons.ios_bed,
            color: _currentIndex == 2 ? Colors.orange : Color(0xFF686868),
            size: 28,),
            title: Text(
              'Bedtime',
              style: TextStyle(
                color: _currentIndex == 2 ? Colors.orange : Color(0xFF686868),
                fontFamily: "Helvetica",
                fontSize: 11,),),),
          BottomNavigationBarItem(icon: Icon(InTimeIcons.ios_stopwatch,
            color: _currentIndex == 3 ? Colors.orange : Color(0xFF686868),
            size: 28,),
            title: Text(
              'Stopwatch',
              style: TextStyle(
                color: _currentIndex == 3 ? Colors.orange : Color(0xFF686868),
                fontFamily: "Helvetica",
                fontSize: 11,),),),
          BottomNavigationBarItem(icon: Icon(InTimeIcons.ios_timer,
            color: _currentIndex == 4 ? Colors.orange : Color(0xFF686868),
            size: 28,),
            title: Text(
              'Timer', style: TextStyle(
              color: _currentIndex == 4 ? Colors.orange : Color(0xFF686868),
              fontFamily: "Helvetica",
              fontSize: 11,),),),
        ],),);
  }
}


