import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 32),
        ),
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _output = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculate();
      } else if (value == 'C') {
        _input = '';
        _output = '';
      } else {
        _input += value;
      }
    });
  }

  void _calculate() {
    try {
      final expression = Expression.parse(_input);
      final evaluator = const ExpressionEvaluator();
      var result = evaluator.eval(expression, {});
      _output = result.toString();
    } catch (e) {
      _output = 'Error';
    }
  }

  Widget _buildButton(String value, {Color color = Colors.blue, double fontSize = 20}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          elevation: 6,
        ),
        child: Text(
          value,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 8,
                margin: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(_output, style: Theme.of(context).textTheme.headlineMedium),
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(_input, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton('+', fontSize: 28),
                        _buildButton('-', fontSize: 28),
                        _buildButton('*', fontSize: 28),
                        _buildButton('/', color: Colors.blue, fontSize: 28),
                        _buildButton('C', color: Colors.red, fontSize: 28),
                      ],
                    ),
                    VerticalDivider(width: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
                        padding: EdgeInsets.all(10),
                        children: [
                          _buildButton('7', fontSize: 36),
                          _buildButton('8', fontSize: 36),
                          _buildButton('9', fontSize: 36),
                          _buildButton('4', fontSize: 36),
                          _buildButton('5', fontSize: 36),
                          _buildButton('6', fontSize: 36),
                          _buildButton('1', fontSize: 36),
                          _buildButton('2', fontSize: 36),
                          _buildButton('3', fontSize: 36),
                          _buildButton('0', fontSize: 36),
                          _buildButton('.', fontSize: 36),
                          _buildButton('=', color: Colors.green, fontSize: 36),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
