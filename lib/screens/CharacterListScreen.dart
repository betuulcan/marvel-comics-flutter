import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/CharacterListItemScreen.dart';
import '../models/Characters.dart';

class CharacterListScreen extends StatefulWidget {
  final Future<Characters> characters;

  CharacterListScreen(this.characters);
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comics'),
      ),
      body: Center(
        child: FutureBuilder<Characters>(
          future: widget.characters,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView(
                padding: const EdgeInsets.all(15),
                children: snapshot.data.data.results.map(
                  (result) {
                    return CharacterListItemScreen(result);
                  },
                ).toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
