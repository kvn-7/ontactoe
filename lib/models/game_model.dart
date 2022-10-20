import 'package:ontactoe/models/box_model.dart';
import 'package:ontactoe/models/pin_model.dart';
import 'package:ontactoe/models/player_model.dart';

class Game {
  bool? isJoinable;
  List<Player>? players;
  List<BoxModel>? boxs;
  Player? winner;
  int? rounds;
  int? turn;

  Game(
      {this.boxs,
      this.isJoinable,
      this.players,
      this.rounds,
      this.winner,
      this.turn});

  Map<String, dynamic> toJson() {
    Map playersMap = {};
    for (var i = 0; i < players!.length; i++) {
      playersMap.addAll({'player$i': players![i].toMap()});
    }
    Map boxsMap = {};
    for (var i = 0; i < boxs!.length; i++) {
      boxsMap.addAll({});
    }
    return {
      'isJoinable': true,
      'players': playersMap,
      'turn': 0,
      'winner': null,
      'rounds': 6,
      'boxs': null
    };
  }

  factory Game.fromJson(Map<dynamic, dynamic> json) {
    List playersmap = json['players'];
    List<Player> players = [];
    // playersmap.forEach(
    //   (key, value) {
    //     players.add(Player.fromMap(value));
    //   },
    // );
    for (var i = 0; i < playersmap.length; i++) {
      players.add(Player.fromMap(playersmap[i] as Map));
    }

    List boxsmap = json['boxs'];
    List<BoxModel> boxs = [];
    // boxsmap.forEach(
    //   (key, value) {
    //     boxs.add(BoxModel.fromJson(value));
    //   },
    // );
    for (var i = 0; i < boxsmap.length; i++) {
      boxs.add(BoxModel.fromJson(boxsmap[i] as Map));
    }

    List pinsmap = json['pins'];
    List<PinModel> pins = [];
    for (var i = 0; i < pinsmap.length; i++) {
      pins.add(PinModel.fromJson(pinsmap[i] as Map));
    }
    Player? winner;
    if (json['winner'] != null) {
      winner = Player.fromMap(json['winner']);
    }

    return Game(
        isJoinable: json['isJoinable'],
        players: players,
        winner: winner,
        boxs: boxs,
        turn: json['turn'],
        rounds: json['rounds']);
  }
}
