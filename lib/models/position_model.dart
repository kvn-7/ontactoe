class Position {
  double? left;
  double? bottom;
  Position({this.left, this.bottom});
  Map<String, dynamic> toMap() {
    return {'left': left, 'bottom': bottom};
  }

  factory Position.fromJson(Map json) {
    return Position(
        left: (json['left'] as int).toDouble(),
        bottom: (json['bottom'] as int).toDouble());
  }
}
