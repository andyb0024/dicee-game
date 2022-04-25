import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("MY Dicee"),
        backgroundColor: Color(0xff2D826E),
      ),
      backgroundColor: Color(0xff44C4A5),
      body: DicePage(),
    ),
  ));
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  Timer? timer;
  static const maxSeconds = 20;
  int seconds = maxSeconds;
  var counter = 0;
  var leftDiceNumber = 1;
  var rightDiceNumber = 1;
  var resultDice = 0;

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  void stopDice() {
    leftDiceNumber = 2;
    rightDiceNumber = 1;
  }

  void diceScore() {
    var currentResultDice;
    leftDiceNumber = Random().nextInt(6) + 1;
    rightDiceNumber = Random().nextInt(6) + 1;
    if (leftDiceNumber == rightDiceNumber) {
      resultDice += 1;
      currentResultDice = resultDice += 1;
    }
    if (seconds == 0) {
      // reset the score to 0 when the second is 0
      setState(() {
        stopDice();
      });
    }
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
      resetScore();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    } else {
      timer?.cancel();
    }
  }

  void resetScore() {
    setState(() {
      resultDice = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Card(
            color: Color(0xffFFFBFA),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Color(0xff4E545C),
                size: 50,
              ),
              title: Text(
                "Score:  $resultDice",
                style: TextStyle(
                  fontSize: 50,
                  // color: Color(0xffE16948),
                  color: Color(0xff4E545C),
                ),
              ),
            ),
          ),
          Card(
            color: Color(0xff4E545C),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Color(0xff44C4A5),
                size: 50,
              ),
              title: Text(
                "Time: $seconds sec",
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff44C4A5),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    changeDiceFace();
                    diceScore();
                  },
                  child: Image.asset('images/dice$leftDiceNumber.png'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    changeDiceFace();
                    diceScore();
                  },
                  child: Image.asset('images/dice$rightDiceNumber.png'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              startTimer();
            },
            child: Text(
              "Start",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Color(0xffED674C),
                padding: EdgeInsets.all(10.0)),
          ),
        ],
      ),
    );
  }
}
