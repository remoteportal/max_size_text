import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:max_size_text/max_size_text.dart';

// https://flutter.dev/docs/cookbook/testing/widget/introduction#3-create-a-testwidgets-test

void main() {
  testWidgets('test the thing!', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        child: MaxSizeText(
            text:
                'The Courage to Be Disliked: The Japanese Phenomenon That Shows You How to Change Your Life and Achieve Real Happiness',
            textStyle: new TextStyle(
                color: Colors.red[800], fontSize: 32, fontFamily: 'Roboto')),
        textDirection: TextDirection.ltr));
  });
}
