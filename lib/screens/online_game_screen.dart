import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ontactoe/models/game_model.dart';
import 'package:provider/provider.dart';

import '../widgets/game_board.dart';
import '../widgets/waiting_lobby.dart';

class OnlineGameScreen extends StatefulWidget {
  final String id;

  const OnlineGameScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<OnlineGameScreen> createState() => _OnlineGameScreenState();
}

class _OnlineGameScreenState extends State<OnlineGameScreen> {
  @override
  void initState() {
    super.initState();
    // _socketMethods.updateRoomListener(context);
    // _socketMethods.updatePlayersStateListener(context);
    // _socketMethods.pointIncreaseListener(context);
    // _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    // RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('Games/${widget.id}').onValue,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            Game game = Game();
            if (snapshots.data!.snapshot.value != null) {
              game = Game.fromJson((snapshots.data!.snapshot.value as Map));
            }
            return Scaffold(
              body: game.isJoinable!
                  ? WaitingLobby(id: widget.id)
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Player ',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        // roomDataProvider.player1.points
                                        //     .toInt()
                                        //     .toString(),
                                        '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Player ',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        // roomDataProvider.player2.points
                                        //     .toInt()
                                        //     .toString(),
                                        '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            GameBoard(),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'Player ',
                            )
                          ],
                        ),
                      ),
                    ),
            );
          } else {
            return Container();
          }
        });
  }
}
