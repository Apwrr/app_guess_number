import 'package:app_guess_number/Page/utils/helper.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class GuessNumberPage extends StatefulWidget {
  const GuessNumberPage({Key? key}) : super(key: key);

  @override
  State<GuessNumberPage> createState() => _GuessNumberPageState();
}

class _GuessNumberPageState extends State<GuessNumberPage> {
  var _input = '';
  var _message = '';
  final Mycontroller = TextEditingController();
  final MyGame = Game();
  int Count = 0;

  Widget _buildIndicator() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(_input, style: TextStyle(fontSize: 32.0)),
    );
  }

  void _handleClickButton(int num) {
    if (_input.length >= 3) return;
    setState(() {
      if (num == -1) {
        _input = _input.substring(0, _input.length - 1);
      } else {
        _input = _input + num.toString();
      }
    });
  }

  void handleClick() {
    if(_input.isEmpty){
      showMyDialog(context, 'Error', 'กรุณากรอกตัวเลข');
    }
    var guess = int.tryParse((_input));
    var result = MyGame.doGuess(guess!);
    if (result == Result.tooHigh) {
      Count++;
      setState(() {
        _message = '$_input มากเกินไป';
        _input = '';
      });
    } else if (result == Result.tooLow) {
      setState(() {
        Count++;
        _message = '$_input น้อยเกินไป';
        _input = '';
      });
    } else {
      Count++;
      setState(() {
        _message = '$_input ถูกต้อง (ทาย $Count ครั้ง)';
      });
    }
    return;
  }

  Widget _buildNumberButton(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _handleClickButton(num);
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: num != -1 && num != -2
                ? Border.all(
                    color: Colors.black45,
                    width: 1.0,
                  )
                : null,
          ),
          child: num == -1
              ? Icon(Icons.backspace_outlined)
              : Text(
                  num.toString(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Container(
      decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blueGrey,
        Colors.white,
      ],
    )
    ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/guess_logo.png', width: 100.0),
            SizedBox(height: 14.0),
            Text('GUESS', style:
            TextStyle(
                color: Colors.indigo,fontSize: 30.0)
            ),
            Text('THE NUMBER'),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(),
              ],
            ),
            Text(_message, style: TextStyle(fontSize: 16.0)),
            SizedBox(
              height: 36,
            ),
            Column(
              children: [
                for (var row in [
                  [1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]
                ])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i in row) _buildNumberButton(i),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 74.0,width: 74.0,),
                    _buildNumberButton(0),
                    _buildNumberButton(-1),
                  ],
                ),
              ],
            ),
            SizedBox(height: 14.0),
            ElevatedButton(
              onPressed: handleClick,
              child: Text('GUESS'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey.shade900),
              ),
            //Text(_input),
            // Text(_message),
          ],
        ),
      ),
    ),
    );
  }
}
