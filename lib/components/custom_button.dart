import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';

//Class used to create responsive iOS stopwatch buttons

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.actionTitle,
      this.onTapAction,
      this.buttonColor,
      this.borderColor,
      this.sizeValue});

  final Text actionTitle;
  final Function onTapAction;
  final Color buttonColor;
  final Color borderColor;
  final double sizeValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          //TODO: refactor this in a separate class
          return GestureDetector(
            onTap: onTapAction,
            child: Container(
              height: 200,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  Container(
                    height: 93,
                    width: 93,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(46.5),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: actionTitle,
                    ),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (constraints.maxWidth < 500 && constraints.maxWidth > 120) {
          return GestureDetector(
            onTap: onTapAction,
            child: Container(
              height: 180,
              width: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                  ),
                  Container(
                    height: 83,
                    width: 83,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(41.5),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        actionTitle.data,
                        style: actionTitle.style.copyWith(fontSize: 16),
                      ),
                    ),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: onTapAction,
            child: Container(
              height: 150,
              width: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(37.5),
                    ),
                  ),
                  Container(
                    height: 67,
                    width: 67,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(33.5),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        actionTitle.data,
                        style: actionTitle.style.copyWith(fontSize: 12),
                      ),
                    ),
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
