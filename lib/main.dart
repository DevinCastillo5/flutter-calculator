import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clear();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      _result = result.toString();
    } catch (e) {
      _result = 'Error';
    }
  }

  void _clear() {
    _expression = '';
    _result = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                '$_expression = $_result',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Divider(height: 1),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              ...List.generate(9, (index) {
                final number = (index + 1).toString();
                return CalculatorButton(
                  text: number,
                  onPressed: () => _onButtonPressed(number),
                );
              }),
              CalculatorButton(
                text: '0',
                onPressed: () => _onButtonPressed('0'),
              ),
              CalculatorButton(
                text: '+',
                onPressed: () => _onButtonPressed('+'),
              ),
              CalculatorButton(
                text: '-',
                onPressed: () => _onButtonPressed('-'),
              ),
              CalculatorButton(
                text: '*',
                onPressed: () => _onButtonPressed('*'),
              ),
              CalculatorButton(
                text: '/',
                onPressed: () => _onButtonPressed('/'),
              ),
              CalculatorButton(
                text: '=',
                onPressed: () => _onButtonPressed('='),
              ),
              CalculatorButton(
                text: 'C',
                onPressed: () => _onButtonPressed('C'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}