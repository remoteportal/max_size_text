import 'package:flutter/material.dart';
import 'package:max_size_text/max_size_text.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: Center(
                child: MaxSizeText(
                    text:
                        'The Courage to Be Disliked: The Japanese Phenomenon That Shows You How to Change Your Life and Achieve Real Happiness',
                    textStyle: new TextStyle(
                        color: Colors.red[800],
                        fontSize: 32,
                        fontFamily: 'Roboto')))),
      ),
//                child: Text('hello')
    );
  }
}
