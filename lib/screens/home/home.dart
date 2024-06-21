import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/create/create.dart';
import 'package:flutter_rpg/screens/home/character_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const StyledTitle('Your Characters'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const StyledText("Character List"),
              Expanded(
                child:
                    Consumer<CharacterStore>(builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.characters.length,
                    itemBuilder: (_, int index) {
                      return Dismissible(
                          onDismissed: (direction) =>
                              value.removeCharacter(value.characters[index]),
                          direction: DismissDirection.endToStart,
                          key: ValueKey(value.characters[index].id),
                          child: CharacterCard(value.characters[index]));
                    },
                  );
                }),
              ),
              GradientButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const CreateScreen()));
                  },
                  child: const StyledHeading("Create New"))
            ],
          ),
        ));
  }
}
