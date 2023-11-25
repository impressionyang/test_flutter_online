import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: MyRandomWords(),
    );
  }
}

class RandomWordsState extends State<MyRandomWords> {
  final List<WordPair> _wordpairsList = <WordPair>[];
  final TextStyle _biggerfont = const TextStyle(fontSize: 18);
  final Set<WordPair> _wordpairSet = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('data'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.menu), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _wordpairSet.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerfont,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('route favorite'),
              backgroundColor: Colors.purple,
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          final int index = i ~/ 2;
          if (index >= _wordpairsList.length) {
            _wordpairsList.addAll(generateWordPairs().take(1));
          }

          if (i.isOdd) {
            // print('now i $i, index is $index, add devider');
            return Divider(
              thickness: 3.0,
            );
          } else {
            // print('now i $i, index is $index, add row');
            return _buildRow(_wordpairsList[index]);
          }
        });
  }

  Widget _buildRow(WordPair pair) {
    bool alreadySave = _wordpairSet.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerfont,
      ),
      trailing: Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySave) {
            _wordpairSet.remove(pair);
          } else {
            _wordpairSet.add(pair);
          }
        });
      },
    );
  }
}

class MyRandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
