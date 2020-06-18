import 'package:flutter/material.dart';
import './CharacterDetail.dart';
import '../models/Characters.dart';

class CharacterListItemScreen extends StatelessWidget {
  final Results results;

  CharacterListItemScreen(this.results);

  void selectHero(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(CharacterDetail.routeName, arguments: results.id);
  }

  @override
  Widget build(BuildContext context) {
    final String resimurl =
        results.thumbnail.path + "." + results.thumbnail.extension;
    return InkWell(
      onTap: () => selectHero(context),
      splashColor: Theme.of(context).primaryColor,
      //borderRadius: BorderRadius.circular(15),
      child: Container(
        //padding: const EdgeInsets.all(1),
        child: Hero(
          tag: results.name,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  resimurl,
                  width: 111,
                  fit: BoxFit.fitHeight,
                ),
                Text(
                  results.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
