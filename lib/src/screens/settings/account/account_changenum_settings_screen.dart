import 'package:flutter/material.dart';

class AccountChangeNumSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final String text1 = 'Changing your phone number will migrate '
    //     'your account info, groups & settings.';

    // final String text2 = 'Before proceeding, please confirm that you are '
    //     'able to receive SMS or calls at your new number.';

    // final String text3 = 'If you have both a new phone & a new number, '
    //     'first change your number on your old phone.';

    return Scaffold(
      appBar: AppBar(
        title: Text('Change number'),
      ),
      body: Column(
        children: <Widget>[
//          Flexible(
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(top: 60.0, bottom: 28.0),
//                  child: SizedBox(
//                    height: 120,
//                    width: 120,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(60.0),
//                        color: secondaryColor,
//                      ),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                  child: Text(
//                    text,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      fontSize: 16.0,
//                      height: 1.1,
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: RaisedButton(
//              color: fabBgColor,
//              child: Text(
//                'ENABLE',
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//              onPressed: (){
//                Application.router.navigateTo(
//                  context,
//                  Routes.accountEnableTwoStepSettings,
//                  transition: TransitionType.inFromRight,
//                );
//              },
//            ),
//          )
        ],
      ),
    );
  }
}