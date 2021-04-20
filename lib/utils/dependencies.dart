import 'package:in_time/constants.dart' show CurrentTime;

class Dependencies {
  //Instatiate a new Stopwatch
  final Stopwatch stopwatch = new Stopwatch();

  //List of Strings = future recorded laps
  final List<String> savedTimeList = List<String>();
  final List<String> totalTimeList = List<String>();

  Dependencies(){
    //Empty lines for the iOS style listview
    for(var i = 0; i < 7; i++){
      savedTimeList.add('0');
      totalTimeList.add('0');
    }
  }

  clearAndReset(){
    totalTimeList.clear();
    savedTimeList.clear();
    for(var i = 0; i < 7; i++){
      savedTimeList.add('0');
      totalTimeList.add('0');
    }
  }


  transformMilliSecondsToString(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String millisecondsStr = (milliseconds % 1000).toString().padLeft(3, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr,$millisecondsStr';
  }

  transformMilliSecondsToTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    return CurrentTime(
      milliseconds: milliseconds % 1000,
      seconds: seconds % 60,
      minutes: minutes % 60,
    );
  }
}
