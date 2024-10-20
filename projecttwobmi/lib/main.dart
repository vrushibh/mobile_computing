import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BMIHomePage(),
    );
  }
}

class BMIHomePage extends StatefulWidget {
  @override
  _BMIHomePageState createState() => _BMIHomePageState();
}

class _BMIHomePageState extends State<BMIHomePage> {
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _result = '';
  String _category = '';
  String _error = '';
  String _description = '';
  List<String> _history = [];
  bool _isMetric = true;

  void _calculateBMI() {
    setState(() {
      _result = '';
      _category = '';
      _error = '';
      _description = '';

      // Validate inputs
      int? age = int.tryParse(_ageController.text);
      double? height = double.tryParse(_heightController.text);
      double? weight = double.tryParse(_weightController.text);

      if (age == null || age < 1 || age > 120) {
        _error = 'Please enter a valid age (1-120).';
        return;
      }
      if (height == null || height < 30 || height > 250) {
        _error = 'Please enter a valid height (30-250 cm).';
        return;
      }
      if (weight == null || weight < 10 || weight > 300) {
        _error = 'Please enter a valid weight (10-300 kg).';
        return;
      }

      // Calculate BMI
      double bmi = weight / ((height / 100) * (height / 100));
      _result = 'Your BMI is: ${bmi.toStringAsFixed(2)}';
      _category = _getBMICategory(bmi);
      _description = _getBMIDescription(bmi);
      _history.add(_result + ' - ' + _category);
    });
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  String _getBMIDescription(double bmi) {
    if (bmi < 18.5) {
      return 'You are considered underweight. Consider consulting with a healthcare provider.';
    } else if (bmi < 24.9) {
      return 'You have a normal weight. Keep up the good work!';
    } else if (bmi < 29.9) {
      return 'You are overweight. It might be a good idea to adopt a healthier lifestyle.';
    } else {
      return 'You are in the obesity category. Please consult with a healthcare provider for guidance.';
    }
  }

  void _resetFields() {
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _result = '';
      _category = '';
      _error = '';
      _description = '';
    });
  }

  void _toggleUnit() {
    setState(() {
      _isMetric = !_isMetric;
      _resetFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Use Imperial Units (lbs/inches)'),
                value: !_isMetric,
                onChanged: (value) => _toggleUnit(),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age (years)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(labelText: _isMetric ? 'Height (cm)' : 'Height (inches)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: _isMetric ? 'Weight (kg)' : 'Weight (lbs)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: Text('Calculate BMI'),
              ),
        ElevatedButton(
          onPressed: _resetFields,
          child: Text('Reset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Use backgroundColor instead of primary
          ),
        ),

              SizedBox(height: 20),
              if (_error.isNotEmpty)
                Text(
                  _error,
                  style: TextStyle(color: Colors.red),
                ),
              if (_result.isNotEmpty)
                Column(
                  children: [
                    Text(
                      _result,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _category,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _description,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'BMI History:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ..._history.map((entry) => Text(entry)).toList(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
