import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ontactoe/models/player_model.dart';
import 'package:ontactoe/resources/lobby_methods.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:color_parser/color_parser.dart';

import '../constants.dart';
import '../models/game_model.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => JoinRoomScreenState();
}

class JoinRoomScreenState extends State<JoinRoomScreen> {
  ColorSwatch? playercolor;

  String? firstPlayerColor;
  // final SocketMethods _socketMethods = SocketMethods();
  String roomid = '';
  _showcolorpicker(color) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: MaterialColorPicker(
              allowShades: false,
              onMainColorChange: (selectedcolor) {
                Navigator.of(context).pop();
                print(selectedcolor);
                setState(() {
                  playercolor = selectedcolor!;
                });
              },
              selectedColor: playercolor,
              colors:
                  colors.values.where((element) => element != color).toList(),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // _socketMethods.getFirstPlayerColorListener(context);

    // _socketMethods.joinRoomSuccessListener(context);
    // _socketMethods.errorOccuredListener(context);
    // _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    // firstPlayerColor = roomDataProvider.player1.color.isNotEmpty
    //     ? roomDataProvider.player1.color
    //     : null;
    // if (playercolor == null && firstPlayerColor != null) {
    //   playercolor = colors.entries
    //       .firstWhere((element) => element.key != firstPlayerColor)
    //       .value;
    // }
    return StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('Games/$roomid').onValue,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            Game game = Game();
            if (snapshots.data!.snapshot.value != null &&
                roomid.isNotEmpty &&
                roomid.startsWith('-')) {
              game = Game.fromJson((snapshots.data!.snapshot.value as Map));
              firstPlayerColor = game.players!.first.color;
            } else {
              firstPlayerColor = null;
            }
            if (playercolor == null && firstPlayerColor != null) {
              playercolor = colors.entries
                  .firstWhere((element) => element.key != firstPlayerColor)
                  .value;
            }
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
                          'Enter Room ID',
                          style: primarytextstyle,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          roomid = value;
                          // _socketMethods.getFirstPlayerColor(roomid);
                        });
                      },
                    ),
                  ),
                  if (firstPlayerColor != null)
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
                  if (firstPlayerColor != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: InkWell(
                        onTap: () {
                          var color = colors[firstPlayerColor]!;
                          print(color);
                          _showcolorpicker(color);
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
                                    .firstWhere((element) =>
                                        element.value == playercolor)
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
                        // _socketMethods.joinRoom(
                        //     colors.entries
                        //         .firstWhere((element) => element.value == playercolor)
                        //         .key
                        //         .toString(),
                        //     roomid);
                        Player player2 = Player(
                            color: colors.entries
                                .firstWhere(
                                    (element) => element.value == playercolor)
                                .key
                                .toString(),
                            points: 0,
                            playerindex: 1);
                        if (player2.color != null &&
                            player2.color!.isNotEmpty) {
                          print('ok');
                          await LobbyMethods()
                              .joinLobby(player2, roomid, game, context);
                        }
                      },
                      child: Container(
                        child: Text('Join Room'),
                      )),
                ],
              ),
            ));
          } else {
            return Container();
          }
        });
  }
}
