import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: new MyRandomWords(),
    );
  }
}

class RandomWordsState extends State<MyRandomWords> {
  final List<WordPair> _wordpairsList = <WordPair>[];
  final TextStyle _biggerfont = const TextStyle(fontSize: 18);
  final Set<WordPair> _wordpairSet = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('data'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.menu), onPressed: _pushSaved),
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
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          final int index = i ~/ 2;
          if (index >= _wordpairsList.length) {
            _wordpairsList.addAll(generateWordPairs().take(1));
          }

          if (i.isOdd) {
            // print('now i $i, index is $index, add devider');
            return new Divider(
              thickness: 3.0,
            );
          } else {
            // print('now i $i, index is $index, add row');
            return _buildRow(_wordpairsList[index]);
          }
        });
  }

  Widget _buildRow(WordPair pair) {
    bool _alreadySave = _wordpairSet.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerfont,
      ),
      trailing: new Icon(
        _alreadySave ? Icons.favorite : Icons.favorite_border,
        color: _alreadySave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySave) {
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
  RandomWordsState createState() => new RandomWordsState();
}
