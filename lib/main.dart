import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  // String _formattedText = '';

  void _formatText() {
    String enteredText = _textController.text;

    // Remove existing commas and any leading/trailing spaces
    enteredText = enteredText.replaceAll(',', '').trim();

    // Add commas every three digits from the right
    String formattedText = '';
    int length = enteredText.length;
    int commaCount = (length / 3).floor();
    for (int i = 0; i < commaCount; i++) {
      int startIndex = length - (i + 1) * 3;
      int endIndex = length - i * 3;
      if (startIndex < 0) startIndex = 0;
      formattedText =
          ',${enteredText.substring(startIndex, endIndex)}$formattedText';
    }
    formattedText = enteredText.substring(0, length % 3) + formattedText;

    if (formattedText.startsWith(',')) {
      formattedText = formattedText.replaceFirst(',', '');
    }
    if (formattedText.startsWith('0,')) {
      formattedText = formattedText.replaceFirst('0,', '');
    }
    _textController.text = formattedText;

    // setState(() {
    //   // _formattedText = formattedText;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField with Commas (UK Numbering System)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              maxLength: 13,
              controller: _textController,
              onChanged: (value) {
                _formatText();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter a number'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
