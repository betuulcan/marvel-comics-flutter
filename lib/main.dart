import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './screens/CharacterListScreen.dart';
import './screens/CharacterDetail.dart';
import './models/Characters.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Future<Characters> fetchPost() async {
  final response = await http.get(
      'http://gateway.marvel.com/v1/public/characters?modifiedSince=01.01.2016&orderBy=name&limit=80&apikey=c83c5105e8b62e9e481adbe2964e3e5c&hash=becf97e3e7b5b7bf24843e20715990b6&ts=15');
  if (response.statusCode == 200) {
    return Characters.fromJson(json.decode(response.body));
  } else {
    throw Exception('Yüklenirken hata oluştu.');
  }
}

class _MyAppState extends State<MyApp> {
  Future<Characters> _characters;
  List<Results> characters;
  @override
  void initState() {
    super.initState();
    _characters = fetchPost();
    _characters.then((result) {
      characters = result.data.results;
    });
  }

  Results _getCharacter(int id) {
    return characters.firstWhere((character) => character.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.amber[300],
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => CharacterListScreen(_characters),
        CharacterDetail.routeName: (ctx) => CharacterDetail(_getCharacter),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CharacterListScreen(_characters),
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DeliMeals'),
//       ),
//       body: Center(
//         child: Text('Navigation Time!'),
//       ),
//     );
//   }
// }
