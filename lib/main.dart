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
  String _startMeasure = '';
  String _convertMeasure = '';
  final TextStyle inputStyle =
      TextStyle(fontSize: 20, color: Colors.black);
  final TextStyle typography = TextStyle(fontSize: 24, color: Colors.grey[700]);

  @override
  void initState() {
    _numberFrom = 0.0;
    _startMeasure = 'meters';
    _convertMeasure = 'feet';
    super.initState();
  }

  // bool operator ==(dynamic other) =>
  //     other != null && other is TimeSelection && this.hour == other.hour;
  //
  // @override
  // int get hashCode => super.hashCode;

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
                Text(
                  _numberFrom.toString(),
                  style: typography,
                ),
                Spacer()
              ],
            ),
          ),
        ));
  }
}
