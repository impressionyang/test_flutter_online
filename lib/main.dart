import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var word_pairs = new WordPair.random();
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text(word_pairs.asPascalCase),
        ),
      ),
    );
  }
}
