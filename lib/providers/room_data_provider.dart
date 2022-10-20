import 'package:flutter/material.dart';

import '../models/box_model.dart';
import '../models/pin_model.dart';
import '../models/player_model.dart';
import '../models/position_model.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  List<PinModel> _pins = [];
  List<BoxModel> _boxs = [];
  Player _player1 = Player(
    color: '',
    socketID: '',
    points: 0,
    playerindex: 0,
  );

  Player _player2 = Player(
    color: '',
    socketID: '',
    points: 0,
    playerindex: 1,
  );

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledBoxes => _filledBoxes;
  Player get player1 => _player1;
  Player get player2 => _player2;

  List<PinModel> get pins => _pins;
  List<BoxModel> get boxs => _boxs;

  void initPins() {
    pins.clear();
    for (var i = 0; i < 12; i++) {
      pins.add(PinModel(
          index: i < 6 ? i : i - 6,
          position: Position(
              left: i < 6 ? i * 50 : (i - 6) * 50, bottom: i < 6 ? 410 : 0),
          playerindex: i < 6 ? 0 : 1));
    }
  }

  void resetPins() {
    pins.clear();
    for (var i = 0; i < 12; i++) {
      pins.add(PinModel(
          index: i < 6 ? i : i - 6,
          position: Position(
              left: i < 6 ? i * 50 : (i - 6) * 50, bottom: i < 6 ? 410 : 0),
          playerindex: i < 6 ? 0 : 1));
    }
    notifyListeners();
  }

  void initBoxs() {
    boxs.clear();
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        boxs.add(BoxModel(rowindex: j, columnindex: i));
      }
    }
  }

  void resetBoxs() {
    boxs.clear();
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        boxs.add(BoxModel(rowindex: j, columnindex: i));
      }
    }
    notifyListeners();
  }

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(
      int pinPlayerIndex, int pinIndex, int boxRowIndex, int boxColumnIndex) {
    var pin = pins.firstWhere(
      (element) =>
          element.index == pinIndex && element.playerindex == pinPlayerIndex,
    );
    var box = boxs.firstWhere(
      (element) =>
          element.rowindex == boxRowIndex &&
          element.columnindex == boxColumnIndex,
    );
    box.currentpin = pin;
    updatePinPosition(pin, box);
    notifyListeners();
  }

  void updatePinPosition(PinModel pin, BoxModel box) {
    var i = box.rowindex;
    var j = box.columnindex;
    pin.position!.left = 28 + (j * 100);
    pin.position!.bottom = 10 + ((3 - i) * 100);
    pins[pin.index + (6 * pin.playerindex)].istricked = true;
    pins[pin.index + (6 * pin.playerindex)].isselected = false;
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }
}
