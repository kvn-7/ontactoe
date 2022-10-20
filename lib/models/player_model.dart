class Player {
  String? color;
  String? socketID;
  double? points;
  int? playerindex;
  Player({
    this.color,
    this.socketID,
    this.points,
    this.playerindex,
  });

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'points': points,
      'playerindex': playerindex,
    };
  }

  factory Player.fromMap(Map<dynamic, dynamic> map) {
    return Player(
      color: map['color'] ?? '',
      // socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerindex: map['playerindex'] ?? '',
    );
  }

  Player copyWith({
    String? color,
    String? socketID,
    double? points,
    int? playerindex,
  }) {
    return Player(
      color: color ?? this.color,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerindex: playerindex ?? this.playerindex,
    );
  }
}
