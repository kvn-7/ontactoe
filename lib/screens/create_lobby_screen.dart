import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:color_parser/color_parser.dart';
import 'package:ontactoe/models/player_model.dart';
import 'package:ontactoe/resources/lobby_methods.dart';

import '../constants.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  ColorSwatch playercolor = Colors.blue;
  // final SocketMethods _socketMethods = SocketMethods();
  Player player = Player();
  _showcolorpicker() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: MaterialColorPicker(
              allowShades: false,
              onMainColorChange: (color) {
                Navigator.of(context).pop();
                setState(() {
                  playercolor = color!;
                });
              },
              selectedColor: playercolor,
              colors: colors.values.toList(),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text(
                  'Select your color',
                  style: primarytextstyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: InkWell(
              onTap: () {
                _showcolorpicker();
              },
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: playercolor, shape: BoxShape.circle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      colors.entries
                          .firstWhere((element) => element.value == playercolor)
                          .key
                          .toString()
                          .toUpperCase(),
                      style: primarytextstyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                // _socketMethods.createRoom(colors.entries
                //     .firstWhere((element) => element.value == playercolor)
                //     .key
                //     .toString());
                String color = colors.entries
                    .firstWhere((element) => element.value == playercolor)
                    .key
                    .toString();
                player.color = color;
                player.playerindex = 0;
                player.points = 0;
                await LobbyMethods().createLobby(color, player, context);
              },
              child: Container(
                child: Text('Create Room'),
              )),
        ],
      ),
    ));
  }
}
