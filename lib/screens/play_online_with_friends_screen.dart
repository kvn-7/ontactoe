import 'package:flutter/material.dart';

import 'create_lobby_screen.dart';
import 'join_lobby_screen.dart';

class PlayOnlineWithFriend extends StatefulWidget {
  const PlayOnlineWithFriend({Key? key}) : super(key: key);

  @override
  State<PlayOnlineWithFriend> createState() => _PlayOnlineWithFriendState();
}

class _PlayOnlineWithFriendState extends State<PlayOnlineWithFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CreateRoomScreen()));
                },
                child: Container(
                  child: Text('Create Room'),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => JoinRoomScreen()));
                },
                child: Container(
                  child: Text('Join Room'),
                ))
          ],
        ),
      ),
    );
  }
}
