import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'screens/home_screen.dart';
import 'screens/worldclock_screen.dart';
import 'screens/alarm_screen.dart';
import 'screens/bedtime_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/login_screen.dart';
import 'screens/token_screen.dart';
import 'utils/custom_scroll_behavior.dart';
import 'constants.dart';

void main() => runApp(InTimeApp());

class InTimeApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          title: kNavTitleTextStyle,
          display1: kTextStyle,
          display2: kTextStyle,
          display3: kTextStyle,
          display4: kTextStyle,
          headline: kTextStyle,
          subhead:kTextStyle,
          subtitle: kTextStyle,
          body1: kTextStyle,
          body2: kTextStyle,
        )
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomeScreen(),
        '/worldclock_screen' : (context) => WorldClock(),
        '/alarm_screen' : (context) => Alarm(),
        '/bedtime_screen' : (context) => BedTime(),
        '/stopwatch_screen' : (context) => StopWatch(),
        '/timer_screen' : (context) => TimerScreen(),
        '/login_screen' : (context) => LoginScreen(),
        '/token_screen' : (context) => TokenScreen(),
      },
    );
  }
}

//TODO: Insert things inside SafeArea widgs

