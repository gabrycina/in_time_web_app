import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/cupertino.dart';
import 'package:in_time/presentation/in_time_icons_icons.dart';
import 'package:in_time/components/custom_text_field.dart';

class TokenScreen extends StatefulWidget {
  @override
  _TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  TextEditingController tokenController = TextEditingController();
  final auth = fb.auth();
  String inputToken;
  String accountName;

  @override
  void initState() {
    super.initState();
    var loggedUser = auth.currentUser;
    accountName = loggedUser.email;
  }

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
                maxLength: 16,
                obscure: false,
                controller: tokenController,
                placeholderText: 'Your token',
                customIcon: InTimeIcons.ios_key,
                onChangedFunction: (value) {
                  setState(() {
                    inputToken = value;
                  });
                },
              ),
            ),
            CupertinoButton(
                color: CupertinoColors.activeGreen,
                child: Text(
                  'UNLOCK SECRET FEATURE',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontFamily: 'Helvetica',
                      fontSize: 15),
                ),
                onPressed: () async {
                  //TODO: Set loading on
                  QuerySnapshot tokenRefs = await fb
                      .firestore()
                      .collection('tokens')
                      .where('token', '==', tokenController.text)
                      .get();

                  List<DocumentSnapshot> tokenList = tokenRefs.docs;

                  final length = tokenRefs.size.toInt();

                  if (length == 0) {
                    // No token
                    Navigator.pop(context, false);
                  } else {
                    //Get the token reference
                    DocumentReference tokenRef = await fb
                        .firestore()
                        .collection('tokens')
                        .doc('${tokenList[0].id}');

                    QuerySnapshot result = await fb
                        .firestore()
                        .collection('utenti')
                        .where('accountName', '==', accountName)
                        .get();

                    List<DocumentSnapshot> list = result.docs;

                    //Get the user reference
                    DocumentReference userRef = await fb
                        .firestore()
                        .collection('utenti')
                        .doc('${list[0].id}');

                    //If token is not been used
                    bool isUnlocked = await tokenRef.get().then((snapshot) {
                      return snapshot.get('assigned');
                    });

                    if(!isUnlocked){
                      await tokenRef.set({
                        'assigned': true,
                        'assignedAccount': accountName,
                        'token': tokenList[0].id
                      });
                      await userRef.set({
                        'accountName': accountName,
                        'unlocked': true,
                        'token': tokenList[0].id,
                      });

                      Navigator.pop(context, true);
                    }else{
                      // No valid token
                      Navigator.pop(context, false);
                    }
                  }
                }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
