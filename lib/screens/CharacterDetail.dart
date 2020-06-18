import 'package:flutter/material.dart';
import '../models/Characters.dart';

class CharacterDetail extends StatelessWidget {
  static const routeName = '/character-detail';
  final Function getCharacter;
  CharacterDetail(this.getCharacter);
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as int;
    var character = getCharacter(id) as Results;
    final String resimurl =
        character.thumbnail.path + "." + character.thumbnail.extension;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                resimurl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Stories'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Text(
                      character.stories.items[index].name,
                    ),
                  ),
                ),
                itemCount: character.stories.items.length,
              ),
            ),
            buildSectionTitle(context, 'Series'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(
                        character.stories.items[index].name,
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                  ],
                ),
                itemCount: character.stories.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
