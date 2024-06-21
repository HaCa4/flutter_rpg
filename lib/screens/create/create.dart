import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';

import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import "package:uuid/uuid.dart";

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

//handle selection

  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading("Missing Character Name"),
              content: const StyledText(
                  "Every good RPG character needs a great name"),
              actions: [
                GradientButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeading("Close"))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });

      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading("Missing  Slogan"),
              content: const StyledText("Remember to add slogan"),
              actions: [
                GradientButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const StyledHeading("Close"))
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(Character(
      id: uuid.v4(),
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
      vocation: selectedVocation,
    ));

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const StyledTitle('Character Creation'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor),
                ),
                const Center(
                  child: StyledHeading("Welcome New Player"),
                ),
                const Center(
                  child:
                      StyledText("Create a name & slogan for your character"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2),
                    label: StyledText('Character Name'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _sloganController,
                  style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.chat),
                    label: StyledText('Character Slogan'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Select Vocation Title
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor),
                ),
                const Center(
                  child: StyledHeading("Choose a vocation"),
                ),
                const Center(
                  child: StyledText("This determines your available skills"),
                ),
                const SizedBox(
                  height: 30,
                ),
                VocationCard(
                  onTap: updateVocation,
                  vocation: Vocation.junkie,
                  selected: selectedVocation == Vocation.junkie,
                ),
                VocationCard(
                    onTap: updateVocation,
                    vocation: Vocation.ninja,
                    selected: selectedVocation == Vocation.ninja),
                VocationCard(
                    onTap: updateVocation,
                    vocation: Vocation.raider,
                    selected: selectedVocation == Vocation.raider),
                VocationCard(
                    onTap: updateVocation,
                    vocation: Vocation.wizard,
                    selected: selectedVocation == Vocation.wizard),
                // Good luck message
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor),
                ),
                const Center(
                  child: StyledHeading("Good luck."),
                ),
                const Center(
                  child: StyledText("And enjoy your journey...."),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GradientButton(
                    onPressed: handleSubmit,
                    child: const StyledHeading('Create Character '),
                  ),
                )
              ]),
            )));
  }
}
