library max_size_text;

import 'package:flutter/material.dart';

class MaxSizeText extends StatefulWidget {
  MaxSizeText(this.text, {this.textStyle});

  final String text;
  final TextStyle? textStyle;

  @override
  MaxSizeTextState createState() {
    return new MaxSizeTextState();
  }
}

class MaxSizeTextState extends State<MaxSizeText> {
  int findWordBoundary(String s, int mid) {
    if (mid >= s.length) {
      return 0;
    }

//    print("in mid=$mid");
    int i = mid;
    while (i > 0) {
      if (s[i] == ' ') {
//        print("MaxSizeTextState: TO-LEFT: $s (${s.length}): ${mid} -> ${i}");
        return i;
      } else {
        i--;
      }
    }

    i = mid;
    while (i < s.length) {
      if (s[i] == ' ') {
//        print("MaxSizeTextState: TO-RIGHT: $s (${s.length}): ${mid} -> ${i}");
        return i;
      } else {
        i++;
      }
    }
//    print("MaxSizeTextState: $s (${s.length}): ${mid} (NO SPACES FOUND)");
    return mid;
  }

  @override
  Widget build(BuildContext context) {
    String s = widget.text;

//    print("s=$s len=${s.length}");

//    TextSpan span = new TextSpan(
//        style: new TextStyle(
//            color: Colors.blue[800], fontSize: 24.0, fontFamily: 'Roboto'),
//        text: "texxxxx");
//    TextPainter tp =
//    new TextPainter(text: span, textDirection: TextDirection.ltr);
//    tp.layout();
//    log("height=${tp.height}");
//    log("width=${tp.width}");
//

    double screenWidth = MediaQuery.of(context).size.width;
//    double height = MediaQuery.of(context).size.height;
    // print("screen: screenWidth=$width height=$height");

    String orig = s;
    int parts = 0;
    int ensureNotInfiniteLoop = 0;
    TextSpan span;
    List<String> a = [];

    //HC//ARB: 30 just to make sure doesn't get into an infinite-loop
    while (ensureNotInfiniteLoop < 30) {
      // keep dividing equally into ever-smaller chunks until it fits horizontally

      s = orig;
      ensureNotInfiniteLoop++;
      parts++;
      //screenWidth("### LOOP $ensureNotInfiniteLoop: parts=$parts");
      bool good = true;
      a.clear();

      void add(String s) {
        a.add(s);

        final span = new TextSpan(style: widget.textStyle, text: s);

        TextPainter tp =
            new TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout();

        if (tp.width > screenWidth) {
          //screenWidth("add: $s => width=${tp.width} => TOO WIDE! ${tp.width} > $screenWidth => !good");
          good = false;
        } else {
          //screenWidth("add: $s => width=${tp.width} <= $screenWidth => good");
        }
      } // add

      if (parts == 1) {
        //screenWidth("parts=1");
        add(s);
      } else {
        int seg = s.length ~/ parts;
        //screenWidth("parts!=1: seg=$seg");
        while (seg > 0 && good) {
          //screenWidth("s.l=${s.length}");
          //screenWidth("parts=$parts");
          int mid;
          if (s.length < seg) {
            // done... just copy rest
            add(s);
            break;
          } else {
            mid = findWordBoundary(s, seg);
            if (mid == 0) {
              //screenWidth('PROBLEM');
              add(s);
              break;
            } else {
              add(s.substring(0, mid));
              s = s.substring(mid + 1);
            }
          }
        }
      }

      if (good) {
        //screenWidth("break");
        break;
      } else {
        //screenWidth("GO AGAIN");
        continue;
      }

////      print("s.l=${s.length}");
////      print("parts=$parts");
//      int mid = findWordBoundary(s, s.length ~/ parts);
//      print("mid=$mid");
//      if (mid == 0) {
////        return Text(s);
//        a.add(s);
//      } else {
//        a.add(s.substring(0, mid));
//        a.add(s.substring(mid + 1));
//      }

//      span = new TextSpan(
//          style: new TextStyle(
//              color: Colors.blue[800], fontSize: 24.0, fontFamily: 'Roboto'),
//          text: s);
//
//      list.add(Center(child: RichText(text: span)));

//      TextPainter tp =
//          new TextPainter(text: span, textDirection: TextDirection.ltr);
//      tp.layout();
//      print("layout: width=${tp.width} height=${tp.height}");
//      if (tp.width < width) {
//        break;
//      }
//      ensureNotInfiniteLoop++;
//      if (true) break;
    } //while

    List<Widget> list = [];
    a.forEach((sub) {
//      print("sub: $sub");
      span = new TextSpan(style: widget.textStyle, text: sub);

      list.add(Center(child: RichText(text: span))); //TODO//HELP:Center
    });

//    return MaterialApp(
//      home: Scaffold(
//        body: SafeArea(
//          child: Column(children: list
////            children: <Widget>[
////              Center(
//////            child: Container(
//////              color: Colors.blue,
//////              width: 300.0,
//////              height: 200.0,
//////              child: FittedBox(
//////                fit: BoxFit.contain,
//////                child: Text(s),
//////              ),
//////            ),
//////              child: Text(s)
////                  child: RichText(text: span)),
////            ],
//              ),
//        ),
//      ),
//    );

    return Column(children: list);
  }
}

//WORKS
//          SizedBox(
//            child: AutoSizeText(
////              widget.text + '!',
//                'a b c d e f g h i',
////            style: TextStyle(fontSize: 20),
//                maxLines: 20,
//                minFontSize: 40),
////            child: Text('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
//            height: 100,
//            width: 100,
//          ),
