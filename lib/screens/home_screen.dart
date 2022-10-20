import 'package:flutter/material.dart';

import 'game_screen.dart';
import 'play_online_with_friends_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => PlayOnlineWithFriend()));
                  },
                  child: Container(
                    child: Text('Play With a Friend Online'),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => GameScreen()));
                  },
                  child: Container(
                    child: Text('Play With a Friend Offline'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
