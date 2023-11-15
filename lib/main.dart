import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new MyRandomWords(),
        ),
      ),
    );
  }
}

class RandomWordsState extends State<MyRandomWords> {
  @override
  Widget build(BuildContext context) {
    final WordPair randomwords = new WordPair.random();
    return new Text(randomwords.asPascalCase);
  }
}

class MyRandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
