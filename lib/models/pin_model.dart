import 'position_model.dart';

class PinModel {
  bool isselected;
  Position? position;
  bool istricked;
  final int index;
  final int playerindex;

  PinModel(
      {this.isselected = false,
      this.position,
      required this.playerindex,
      this.istricked = false,
      required this.index});
  Map<dynamic, dynamic> toJson() {
    return {
      'isSelected': isselected,
      'position': position?.toMap(),
      'isTricked': istricked,
      'index': index,
      'playerIndex': playerindex
    };
  }

  factory PinModel.fromJson(Map json) {
    Position position = Position.fromJson(json['position']);
    return PinModel(
        playerindex: json['playerIndex'],
        index: json['index'],
        isselected: json['isSelected'],
        position: position,
        istricked: json['isTricked']);
  }
}
