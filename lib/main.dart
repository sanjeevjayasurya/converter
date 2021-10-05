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
  final TextStyle inputStyle =
      TextStyle(fontSize: 20, color: Colors.blueGrey[200]);
  final TextStyle typography = TextStyle(fontSize: 24, color: Colors.grey[700]);

  @override
  void initState() {
    _numberFrom = 0.0;
    _startMeasure = '';
    super.initState();
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
                Spacer(),
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
                    items: _measures.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startMeasure = value.toString();
                      });
                    },
                    value: _startMeasure),
                Text((_numberFrom == null) ? '' : _numberFrom.toString())
              ],
            ),
          ),
        ));
  }
}
