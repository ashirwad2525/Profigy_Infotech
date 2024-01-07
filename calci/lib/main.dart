import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorHomePage(title: 'Simple Calculator'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayText = '';
  double _result = 0;

  void _onNumberPressed(String value) {
    setState(() {
      _displayText += value;
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _displayText += ' $operator ';
    });
  }

  void _onEqualsPressed() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_displayText);
      ContextModel cm = ContextModel();
      _result = exp.evaluate(EvaluationType.REAL, cm);
      _displayText = _result.toString();
    } catch (e) {
      _displayText = 'Error';
    }
    setState(() {});
  }

  void _onClearPressed() {
    setState(() {
      _displayText = '';
      _result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displayText,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCalcButton('7'),
                _buildCalcButton('8'),
                _buildCalcButton('9'),
                _buildCalcButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCalcButton('4'),
                _buildCalcButton('5'),
                _buildCalcButton('6'),
                _buildCalcButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCalcButton('1'),
                _buildCalcButton('2'),
                _buildCalcButton('3'),
                _buildCalcButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCalcButton('0'),
                _buildCalcButton('.'),
                _buildCalcButton('=', textColor: Colors.white, backgroundColor: Colors.deepPurple),
                _buildCalcButton('+'),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _onClearPressed, child: Text('C')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalcButton(String value, {Color textColor = Colors.black, Color? backgroundColor}) {
    return ElevatedButton(
      onPressed: () {
        if (value == '=') {
          _onEqualsPressed();
        } else {
          _onNumberPressed(value);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: textColor,
      ),
      child: Text(value, style: TextStyle(fontSize: 20)),
    );
  }
}
