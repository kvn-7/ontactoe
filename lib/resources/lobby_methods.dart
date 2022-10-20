import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ontactoe/models/game_model.dart';
import 'package:ontactoe/models/player_model.dart';
import 'package:ontactoe/resources/game_methods.dart';
import 'package:ontactoe/widgets/waiting_lobby.dart';

import '../screens/online_game_screen.dart';

class LobbyMethods {
  createLobby(String color, Player player1, BuildContext context) async {
    try {
      DatabaseReference games = FirebaseDatabase.instance.ref("Games");
      DatabaseReference game = games.push();
      Map boxs = GameMethods().setBoxs();
      Map pins = GameMethods().setPins();
      game.set({
        'isJoinable': true,
        'players': {0: player1.toMap()},
        'turn': 0,
        'winner': null,
        'rounds': 6,
        'boxs': boxs,
        'pins': pins
      });
      if (game.key != null) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => OnlineGameScreen(
                      id: game.key!,
                    )));
      }
    } catch (e) {
      print(e);
    }
  }

  joinLobby(Player player2, String id, Game game, BuildContext context) async {
    try {
      DatabaseReference gamedata = FirebaseDatabase.instance.ref("Games/$id");
      await gamedata.get().then((snapshot) async {
        if (snapshot.exists) {
          print(snapshot.value);
          if ((snapshot.value as Map)['isJoinable']) {
            await gamedata.update({
              'isJoinable': false,
              'players': {0: game.players![0].toMap(), 1: player2.toMap()}
            }).catchError((onError) {
              print(onError.toString());
              return;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WaitingLobby(id: id),
                ));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
