
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  double _numberFrom = 0.0;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces'
  ];
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  String _startMeasure = '';
  String _convertMeasure = '';
  String _resultMessage = '';
  final TextStyle inputStyle = TextStyle(fontSize: 20, color: Colors.black);
  final TextStyle typography = TextStyle(fontSize: 24, color: Colors.grey[700]);

  @override
  void initState() {
    _numberFrom = 0.0;
    _startMeasure = 'meters';
    _convertMeasure = 'feet';
    super.initState();
  }

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'Choose both fields and enter value to continue';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Converter',
        home: Scaffold(
          appBar: AppBar(title: Text('Converter')),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Spacer(),
                Text(
                  'Value',
                  style: typography,
                ),
                TextField(
                  style: inputStyle,
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberFrom = rv;
                      });
                    }
                  },
                ),
                Spacer(),
                Text(
                  'From',
                  style: typography,
                ),
                DropdownButton(
                  isExpanded: true,
                  value: _startMeasure.isNotEmpty ? _startMeasure : null,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: inputStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasure = value.toString();
                    });
                  },
                ),
                Spacer(),
                Text(
                  'To',
                  style: typography,
                ),
                DropdownButton(
                  isExpanded: true,
                  value: _convertMeasure.isNotEmpty ? _convertMeasure : null,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: inputStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertMeasure = value.toString();
                    });
                  },
                ),
                Spacer(),
                ElevatedButton(
                  child: Text('Convert', style: inputStyle),
                  onPressed: () {
                    if (_startMeasure.isEmpty ||
                        _convertMeasure.isEmpty ||
                        _numberFrom == 0) {
                      return;
                    } else {
                      convert(_numberFrom, _startMeasure, _convertMeasure);
                    }
                  },
                ),
                Text(
                  _resultMessage,
                  style: typography,
                ),
                Spacer()
              ],
            ),
          ),
        ));
  }
}
