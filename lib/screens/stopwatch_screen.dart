import 'package:firebase/src/firestore.dart';
import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/services.dart';
import 'package:in_time/components/custom_button.dart';
import 'package:in_time/constants.dart';
import 'package:in_time/utils/dependencies.dart';
import 'package:in_time/components/build_stopwatch.dart';
import 'package:in_time/components/lap_list_tile.dart';
import 'package:firebase/firebase.dart' as fb;
import 'settings_screen.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  StopWatch({this.key, this.dependencies});

  final Key key;
  final Dependencies dependencies;

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Stopwatch lapStopwatch = Stopwatch();
  String leftButtonText;
  String rightButtonText;
  Color leftButtonColor;
  Color rightButtonColor;
  MediaQuery mediaQuery;

  Timer timer;

  List<int> values;
  int forcedNumber = 9999;
  int selectedLaps = 9999;
  int lapsCompleted = 0;
  bool isNextStopFake = false;
  bool fakeStop = false;
  var loggedUser;

  SnackBar notAuthorizedAccount =
      SnackBar(content: Text('Account non autorizzato'));
  SnackBar failedAuth = SnackBar(content: Text('Fallito tentativo di accesso'));
  SnackBar succesfulLogin =
      SnackBar(content: Text('Login avvenuto con successo'));
  SnackBar badToken =
      SnackBar(content: Text('Token errato o gia\' utilizzato'));
  SnackBar unlockedAccount = SnackBar(content: Text('Account Sbloccato!'));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (widget.dependencies.stopwatch.isRunning) {
      timer = new Timer.periodic(new Duration(milliseconds: 65), updateTime);
      leftButtonText = 'Lap';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Stop';
      rightButtonColor = Color(0xFF351916);
    } else {
      leftButtonText = 'Reset';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Start';
      rightButtonColor = Color(0xFF1c381f);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onDoubleTap: () async {
                      bool isLogged = await isLoggedIn();
                      if (isLogged) {
                        String email = loggedUser.email;

                        //If it's not in the db, now it is
                        await isAlreadySignedUpAndSignUp(email);

                        //Check if it's unlocked
                        bool unlocked = await isUserUnlocked(email);

                        if (unlocked) {
                          values = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(),
                            ),
                          );
                          forcedNumber = values[0];
                          selectedLaps = values[1];
                          lapsCompleted = 0;
                          isNextStopFake = false;
                          fakeStop = false;
                        }
                      } else {
                        loggedUser =
                            await Navigator.pushNamed(context, '/login_screen');

                        print(loggedUser);
                        bool isLogged = await isLoggedIn();
                        if(isLogged){
                          String email = loggedUser.email;

                          // Check is already sign up
                          await isAlreadySignedUpAndSignUp(email);

                          //Check if it's unlocked
                          bool unlocked = await isUserUnlocked(email);

                          if (unlocked) {
                            values = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(),
                              ),
                            );
                            forcedNumber = values[0];
                            selectedLaps = values[1];
                            lapsCompleted = 0;
                            isNextStopFake = false;
                            fakeStop = false;
                          }
                        }
                      }
                    },
                    child: createStopwatch(),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: CustomButton(
                          actionTitle: Text(
                            leftButtonText,
                            style: kButtonTextStyle.copyWith(
                                color: CupertinoColors.inactiveGray),
                          ),
                          onTapAction: saveOrResetWatch,
                          buttonColor: leftButtonColor,
                          borderColor: CupertinoColors.black,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: CustomButton(
                          actionTitle: Text(
                            rightButtonText,
                            style: kButtonTextStyle.copyWith(
                                color: rightButtonColor == Color(0xFF351916)
                                    ? CupertinoColors.destructiveRed
                                    : CupertinoColors.activeGreen),
                          ),
                          onTapAction: startOrStopWatch,
                          buttonColor: rightButtonColor,
                          borderColor: CupertinoColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  'LAP NO.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'HelveticaLight',
                                    color: Color(0xFF3E3E3E),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'SPLIT',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'HelveticaLight',
                                    color: Color(0xFF3E3E3E),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'TOTAL',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'HelveticaLight',
                                    color: Color(0xFF3E3E3E),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        height: 1,
                        color: CupertinoColors.darkBackgroundGray,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.dependencies.savedTimeList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: createListItemText(
                              widget.dependencies.savedTimeList.length,
                              index,
                              widget.dependencies.savedTimeList
                                  .elementAt(index),
                              widget.dependencies.totalTimeList
                                  .elementAt(index)),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateTime(Timer timer) {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  startOrStopWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      if (!isNextStopFake) {
        setState(() {
          leftButtonText = 'Reset';
          leftButtonColor = CupertinoColors.darkBackgroundGray;
          rightButtonText = 'Start';
          rightButtonColor = Color(0xFF1c381f);
          lapStopwatch.stop();
          widget.dependencies.stopwatch.stop();
        });
      } else {
        setState(() {
          leftButtonText = 'Reset';
          leftButtonColor = CupertinoColors.darkBackgroundGray;
          rightButtonText = 'Start';
          rightButtonColor = Color(0xFF1c381f);
          fakeStop = true;
          lapStopwatch.stop();
          widget.dependencies.stopwatch.stop();
        });
      }
    } else {
      leftButtonText = 'Lap';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Stop';
      rightButtonColor = Color(0xFF351916);
      lapStopwatch.start();
      widget.dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 47), updateTime);
    }
  }

  saveOrResetWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {
        widget.dependencies.savedTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                lapStopwatch.elapsedMilliseconds));
        widget.dependencies.totalTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                widget.dependencies.stopwatch.elapsedMilliseconds));
        lapStopwatch.reset();
      });
    } else {
      setState(() {
        lapStopwatch.reset();
        widget.dependencies.stopwatch.reset();
        widget.dependencies.clearAndReset();
      });
      if (isNextStopFake) {
        isNextStopFake = false;
      } else if (lapsCompleted < (selectedLaps - 2)) {
        lapsCompleted++;
        fakeStop = false;
        print(lapsCompleted);
      } else if (lapsCompleted == (selectedLaps - 2)) {
        lapsCompleted = 0;
        isNextStopFake = true;
        print(lapsCompleted);
      }
    }
  }

  Widget createListItemText(
      int listSize, int index, String lapTime, String totalTime) {
    index = listSize - index;
    return LapListTile(
      index: index,
      lapTime: lapTime,
      totalTime: totalTime,
    );
  }

  Widget createStopwatch() {
    if (fakeStop) {
      fakeStop = false;
      return BuildStopwatch(
        dependencies: widget.dependencies,
        fakeStop: (!fakeStop),
        forcedNumber: forcedNumber,
      );
    } else {
      return BuildStopwatch(
        dependencies: widget.dependencies,
        fakeStop: fakeStop,
        forcedNumber: forcedNumber,
      );
    }
  }

  Future<bool> isLoggedIn() async {
    loggedUser = await fb.auth().currentUser;
    print(loggedUser != null);
    if (loggedUser != null)
      return true;
    else
      return false;
  }

  isAlreadySignedUpAndSignUp(String email) async {
    QuerySnapshot result = await fb
        .firestore()
        .collection('utenti')
        .where('accountName', '==', email)
        .get();

    final length = result.size.toInt();

    if (length == 0) {
      // Update data to server if new user
      fb.firestore().collection('utenti').add(
          {'accountName': loggedUser.email, 'unlocked': false, 'token': ''});
    } else {
      List<DocumentSnapshot> list = result.docs;
      return list[0];
    }
  }

  Future<bool> isUserUnlocked(String email) async {
    var isUnlocked;

    var userDoc = await isAlreadySignedUpAndSignUp(email);

    if (userDoc != null) {
      isUnlocked = userDoc.get('unlocked');
      if (isUnlocked) {
        return true;
      } else {
        isUnlocked = await Navigator.pushNamed(context, '/token_screen');
        if (isUnlocked) {
          Scaffold.of(context).showSnackBar(unlockedAccount);
          return true;
        } else {
          Scaffold.of(context).showSnackBar(badToken);
          print('bad token error');
          return false;
        }
      }
    }
  }
}
