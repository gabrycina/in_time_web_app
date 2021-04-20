import 'package:flutter_web/cupertino.dart';

//Just a list tile for laps

class LapListTile extends StatelessWidget {
  LapListTile({this.index, this.lapTime, this.totalTime});

  final int index;
  final String lapTime;
  final String totalTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    //TODO: Solve hardcoded value
                    margin: EdgeInsets.only(left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: lapTime == '0'
                          ? Text(
                              '',
                              style: TextStyle(fontSize: 15),
                            )
                          : Text(
                              'Lap ${index - 7}',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'HelveticaLight'),
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: lapTime == '0'
                      ? Text(
                          '',
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          '$lapTime',
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'HelveticaLight'),
                        ),
                ),
              ),
              Expanded(
                child: Center(
                  child: lapTime == '0'
                      ? Text(
                          '',
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          '$totalTime',
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'HelveticaLight'),
                        ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          height: 1,
          color: CupertinoColors.darkBackgroundGray,
        )
      ],
    );
  }
}
