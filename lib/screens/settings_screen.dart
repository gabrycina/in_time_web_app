import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:in_time/presentation/in_time_icons_icons.dart';
import 'package:in_time/components/custom_text_field.dart';
import 'package:in_time/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<int> values = [0, 0];
  Text lapsHint = Text('');
  Text forcedNumberHint = Text('');
  String selectedLanguage;
  bool isSwitched = false;
  TextEditingController forcedNumberField = TextEditingController();
  TextEditingController lapsField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            InTimeIcons.ios_arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0D0D0D),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: CustomTextField(
                maxLength: 2,
                obscure: false,
                controller: lapsField,
                placeholderText: 'Designated Cycle',
                customIcon: InTimeIcons.ios_stopwatch,
                onChangedFunction: (value) {
                  setState(() {
                    values[1] = int.parse(value);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: CustomTextField(
                maxLength: 3,
                obscure: false,
                controller: forcedNumberField,
                placeholderText: 'Forced Number',
                customIcon: InTimeIcons.ios_calculator,
                onChangedFunction: (value) {
                  setState(() {
                    values[0] = int.parse(value);
                  });
                },
              ),
            ),
            CupertinoButton(
                color: CupertinoColors.activeGreen,
                child: Text(
                  'SAVE AND EXIT',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontFamily: 'Helvetica',
                      fontSize: 15),
                ),
                onPressed: () {
                  if (forcedNumberField.text.contains(RegExp("[0-9]{3}")) &&
                      lapsField.text.contains(RegExp("[2-9]{1,2}"))) {
                    Navigator.pop(context, values);
                  } else if (!forcedNumberField.text
                      .contains(RegExp("[0-9]{3}"))) {
                    setState(() {
                      forcedNumberHint = Text(
                          '\n- The forced number must be 3 digits',
                          style: kErrorTextStyle);
                    });
                  } else {
                    forcedNumberHint = Text('');
                  }
                  if (!lapsField.text.contains(RegExp("[2-9]{1,2}"))) {
                    setState(() {
                      lapsHint = Text(
                        '- Supported designated cycles range from 2 to 10',
                        style: kErrorTextStyle,
                      );
                    });
                  } else {
                    lapsHint = Text('');
                  }
                  FocusScope.of(context).unfocus();
                }),
            Spacer(),
            lapsHint,
            forcedNumberHint,
            Spacer(),
          ],
        ),
      ),
    );
  }
}
