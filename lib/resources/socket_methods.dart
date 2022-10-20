// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:tic_tac_toe/constants.dart';
// import 'package:tic_tac_toe/models/box_model.dart';
// import 'package:tic_tac_toe/models/pin_model.dart';
// import 'package:tic_tac_toe/providers/room_data_provider.dart';
// import 'package:tic_tac_toe/resources/game_methods.dart';
// import 'package:tic_tac_toe/resources/socket_client.dart';
// import 'package:tic_tac_toe/screens/online_game_screen.dart';
// import 'package:tic_tac_toe/widgets/utils.dart';

// class SocketMethods {
//   final _socketClient = SocketClient.instance.socket!;

//   Socket get socketClient => _socketClient;

//   // EMITS
//   void createRoom(String color) {
//     print(color);
//     if (color.isNotEmpty) {
//       print(_socketClient.connected);
//       _socketClient.emit('createRoom', {
//         'color': color,
//       });
//     }
//   }

//   void joinRoom(String color, String roomId) {
//     if (color.isNotEmpty && roomId.isNotEmpty) {
//       _socketClient.emit('joinRoom', {
//         'color': color,
//         'roomId': roomId,
//       });
//     }
//   }

//   void getFirstPlayerColor(String roomId) {
//     if (roomId.isNotEmpty) {
//       _socketClient.emit('getFirstPlayerColor', {'roomId': roomId});
//     }
//   }

//   void tapGrid(PinModel pin, BoxModel box, String roomId) {
//     _socketClient.emit('trick', {
//       'pinPlayerIndex': pin.playerindex,
//       'pinIndex': pin.index,
//       'boxRowIndex': box.rowindex,
//       'boxColumnIndex': box.columnindex,
//       'roomId': roomId,
//     });
//   }

//   // LISTENERS
//   void createRoomSuccessListener(BuildContext context) {
//     _socketClient.on('createRoomSuccess', (room) {
//       print(room);
//       Provider.of<RoomDataProvider>(context, listen: false)
//           .updateRoomData(room);
//       Navigator.push(context,
//           new MaterialPageRoute(builder: (context) => OnlineGameScreen()));
//     });
//   }

//   getFirstPlayerColorListener(BuildContext context) {
//     _socketClient.on('getFirstPlayerColor', (playerData) {
//       Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
//         playerData,
//       );
//     });
//   }

//   void joinRoomSuccessListener(BuildContext context) {
//     _socketClient.on('joinRoomSuccess', (room) {
//       Provider.of<RoomDataProvider>(context, listen: false)
//           .updateRoomData(room);
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => OnlineGameScreen()));
//     });
//   }

//   void errorOccuredListener(BuildContext context) {
//     _socketClient.on('errorOccurred', (data) {
//       showSnackBar(context, data);
//     });
//   }

//   void updatePlayersStateListener(BuildContext context) {
//     _socketClient.on('updatePlayers', (playerData) {
//       Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
//         playerData[0],
//       );
//       Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
//         playerData[1],
//       );
//     });
//   }

//   void updateRoomListener(BuildContext context) {
//     _socketClient.on('updateRoom', (data) {
//       Provider.of<RoomDataProvider>(context, listen: false)
//           .updateRoomData(data);
//     });
//   }

//   void trickedListener(BuildContext context) {
//     _socketClient.on('tricked', (data) {
//       RoomDataProvider roomDataProvider =
//           Provider.of<RoomDataProvider>(context, listen: false);
//       roomDataProvider.updateDisplayElements(
//         data['pinPlayerIndex'],
//         data['pinIndex'],
//         data['boxRowIndex'],
//         data['boxColumnIndex'],
//       );
//       roomDataProvider.updateRoomData(data['room']);
//       // check winnner
//       GameMethods().checkforwinner(context, _socketClient);
//     });
//   }

//   void pointIncreaseListener(BuildContext context) {
//     _socketClient.on('pointIncrease', (playerData) {
//       var roomDataProvider =
//           Provider.of<RoomDataProvider>(context, listen: false);
//       if (playerData['socketID'] == roomDataProvider.player1.socketID) {
//         roomDataProvider.updatePlayer1(playerData);
//       } else {
//         roomDataProvider.updatePlayer2(playerData);
//       }
//     });
//   }

//   void endGameListener(BuildContext context) {
//     _socketClient.on('endGame', (playerData) {
//       showGameDialog(context, '${playerData['nickname']} won the game!');
//       Navigator.popUntil(context, (route) => false);
//     });
//   }
// }
