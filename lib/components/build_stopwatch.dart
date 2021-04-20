import 'package:flutter_web/cupertino.dart';
import 'package:in_time/constants.dart' show CurrentTime;
import 'package:in_time/utils/responsive_layout.dart';
import 'package:in_time/utils/dependencies.dart';

//Class used to return the fake/fair value of the stopwatch

class BuildStopwatch extends StatefulWidget {
  BuildStopwatch({this.dependencies, this.fakeStop, this.forcedNumber});

  final Dependencies dependencies;
  final bool fakeStop;
  final int forcedNumber;

  BuildStopwatchState createState() => BuildStopwatchState();
}

class BuildStopwatchState extends State<BuildStopwatch> {
  CurrentTime currentTime;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fakeStop) {
      //Fake stopwatch result displayed
      return ResponsiveLayout(
        largeScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${widget.forcedNumber.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 130),
          ),
        ),
        mediumScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${widget.forcedNumber.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 110),
          ),
        ),
        smallScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${widget.forcedNumber.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 70),
          ),
        ),
      );
    } else {
      //Fair Stopwatch result displayed
      currentTime = widget.dependencies.transformMilliSecondsToTime(
          widget.dependencies.stopwatch.elapsedMilliseconds);
      return ResponsiveLayout(
        largeScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${currentTime.milliseconds.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 130),
          ),
        ),
        mediumScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${currentTime.milliseconds.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 110),
          ),
        ),
        smallScreen: Center(
          child: Text(
            '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${currentTime.milliseconds.toString().padLeft(3, '0')}',
            style: TextStyle(fontSize: 70),
          ),
        ),
      );
    }
  }
}
