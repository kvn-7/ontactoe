import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatefulWidget {
  final String id;

  const WaitingLobby({Key? key, required this.id}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    // roomIdController = TextEditingController(
    //   text:
    //       Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
    // );
    roomIdController = TextEditingController(text: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Waiting for a player to join...'),
          const SizedBox(height: 20),
          TextField(
            controller: roomIdController,
          )
        ],
      ),
    );
  }
}
