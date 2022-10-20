import 'package:flutter/material.dart';

class Pin extends StatelessWidget {
  final height;

  final color;

  const Pin({Key? key, required this.height, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 40,
      color: color,
    );
  }
}
