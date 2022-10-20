// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// class GameMethods {
//   // void checkWinner(BuildContext context, Socket socketClent) {
//   //   RoomDataProvider roomDataProvider =
//   //       Provider.of<RoomDataProvider>(context, listen: false);

//   //   String winner = '';

//   //   // Checking rows
//   //   if (roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[1] &&
//   //       roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[2] &&
//   //       roomDataProvider.displayElements[0] != '') {
//   //     winner = roomDataProvider.displayElements[0];
//   //   }
//   //   if (roomDataProvider.displayElements[3] ==
//   //           roomDataProvider.displayElements[4] &&
//   //       roomDataProvider.displayElements[3] ==
//   //       roomDataProvider.displayElements[3] != '') {
//   //     winner = roomDataProvider.displayElements[3];
//   //   }
//   //   if (roomDataProvider.displayElements[6] ==
//   //           roomDataProvider.displayElements[7] &&
//   //       roomDataProvider.displayElements[6] ==
//   //           roomDataProvider.displayElements[8] &&
//   //       roomDataProvider.displayElements[6] != '') {
//   //     winner = roomDataProvider.displayElements[6];
//   //   }

//   //   // Checking Column
//   //   if (roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[3] &&
//   //       roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[6] &&
//   //       roomDataProvider.displayElements[0] != '') {
//   //     winner = roomDataProvider.displayElements[0];
//   //   }
//   //   if (roomDataProvider.displayElements[1] ==
//   //           roomDataProvider.displayElements[4] &&
//   //       roomDataProvider.displayElements[1] ==
//   //           roomDataProvider.displayElements[7] &&
//   //       roomDataProvider.displayElements[1] != '') {
//   //     winner = roomDataProvider.displayElements[1];
//   //   }
//   //   if (roomDataProvider.displayElements[2] ==
//   //           roomDataProvider.displayElements[5] &&
//   //       roomDataProvider.displayElements[2] ==
//   //           roomDataProvider.displayElements[8] &&
//   //       roomDataProvider.displayElements[2] != '') {
//   //     winner = roomDataProvider.displayElements[2];
//   //   }

//   //   // Checking Diagonal
//   //   if (roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[4] &&
//   //       roomDataProvider.displayElements[0] ==
//   //           roomDataProvider.displayElements[8] &&
//   //       roomDataProvider.displayElements[0] != '') {
//   //     winner = roomDataProvider.displayElements[0];
//   //   }
//   //   if (roomDataProvider.displayElements[2] ==
//   //           roomDataProvider.displayElements[4] &&
//   //       roomDataProvider.displayElements[2] ==
//   //           roomDataProvider.displayElements[6] &&
//   //       roomDataProvider.displayElements[2] != '') {
//   //     winner = roomDataProvider.displayElements[2];
//   //   } else if (roomDataProvider.filledBoxes == 9) {
//   //     winner = '';
//   //     showGameDialog(context, 'Draw');
//   //   }

//   //   if (winner != '') {
//   //     if (roomDataProvider.player1.playerType == winner) {
//   //       showGameDialog(context, '${roomDataProvider.player1.nickname} won!');
//   //       socketClent.emit('winner', {
//   //         'winnerSocketId': roomDataProvider.player1.socketID,
//   //         'roomId': roomDataProvider.roomData['_id'],
//   //       });
//   //     } else {
//   //       showGameDialog(context, '${roomDataProvider.player2.nickname} won!');
//   //       socketClent.emit('winner', {
//   //         'winnerSocketId': roomDataProvider.player2.socketID,
//   //         'roomId': roomDataProvider.roomData['_id'],
//   //       });
//   //     }
//   //   }
//   // }
//   checkforwinner(context, Socket socketClent) {
//     RoomDataProvider roomDataProvider =
//         Provider.of<RoomDataProvider>(context, listen: false);
//     var boxs = roomDataProvider.boxs;
//     Player? winner;
//     for (var i = 0; i < 3; i++) {
//       var box1 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 0);
//       var box2 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 1);
//       var box3 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 2);
//       bool iseveryboxfilled = box1.currentpin != null &&
//           box2.currentpin != null &&
//           box3.currentpin != null;

//       if (iseveryboxfilled) {
//         bool isboxscurrentpinequal =
//             box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//                 box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//         if (isboxscurrentpinequal)
//           winner = roomDataProvider.player1.playerindex ==
//                   box3.currentpin!.playerindex
//               ? roomDataProvider.player1
//               : roomDataProvider.player2;
//       }
//     }
//     for (var i = 0; i < 3; i++) {
//       var box1 = boxs.firstWhere(
//           (element) => element.rowindex == 0 && element.columnindex == i);
//       var box2 = boxs.firstWhere(
//           (element) => element.rowindex == 1 && element.columnindex == i);
//       var box3 = boxs.firstWhere(
//           (element) => element.rowindex == 2 && element.columnindex == i);
//       bool iseveryboxfilled = box1.currentpin != null &&
//           box2.currentpin != null &&
//           box3.currentpin != null;

//       if (iseveryboxfilled) {
//         bool isboxscurrentpinequal =
//             box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//                 box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//         if (isboxscurrentpinequal)
//           winner = roomDataProvider.player1.playerindex ==
//                   box3.currentpin!.playerindex
//               ? roomDataProvider.player1
//               : roomDataProvider.player2;
//       }
//     }
//     var box1 = boxs.firstWhere(
//         (element) => element.rowindex == 0 && element.columnindex == 0);
//     var box2 = boxs.firstWhere(
//         (element) => element.rowindex == 1 && element.columnindex == 1);
//     var box3 = boxs.firstWhere(
//         (element) => element.rowindex == 2 && element.columnindex == 2);
//     bool iseveryboxfilled = box1.currentpin != null &&
//         box2.currentpin != null &&
//         box3.currentpin != null;

//     if (iseveryboxfilled) {
//       bool isboxscurrentpinequal =
//           box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//               box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//       if (isboxscurrentpinequal)
//         winner =
//             roomDataProvider.player1.playerindex == box3.currentpin!.playerindex
//                 ? roomDataProvider.player1
//                 : roomDataProvider.player2;
//     }
//     box1 = boxs.firstWhere(
//         (element) => element.rowindex == 0 && element.columnindex == 2);
//     box2 = boxs.firstWhere(
//         (element) => element.rowindex == 1 && element.columnindex == 1);
//     box3 = boxs.firstWhere(
//         (element) => element.rowindex == 2 && element.columnindex == 0);
//     iseveryboxfilled = box1.currentpin != null &&
//         box2.currentpin != null &&
//         box3.currentpin != null;

//     if (iseveryboxfilled) {
//       bool isboxscurrentpinequal =
//           box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//               box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//       if (isboxscurrentpinequal)
//         winner =
//             roomDataProvider.player1.playerindex == box3.currentpin!.playerindex
//                 ? roomDataProvider.player1
//                 : roomDataProvider.player2;
//     }

//     if (winner != null) {
//       showGameDialog(context, 'Player ${winner.color} won!');
//       socketClent.emit('winner', {
//         'winnerSocketId': winner.socketID,
//         'roomId': roomDataProvider.roomData['_id'],
//       });
//     } else {
//       checkfordraw(context, socketClent);
//     }
//   }

//   checkfortempwinner(List<BoxModel> boxs) {
//     bool winner = false;
//     for (var i = 0; i < 3; i++) {
//       var box1 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 0);
//       var box2 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 1);
//       var box3 = boxs.firstWhere(
//           (element) => element.rowindex == i && element.columnindex == 2);
//       bool iseveryboxfilled = box1.currentpin != null &&
//           box2.currentpin != null &&
//           box3.currentpin != null;

//       if (iseveryboxfilled) {
//         bool isboxscurrentpinequal =
//             box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//                 box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//         if (isboxscurrentpinequal) winner = true;
//       }
//     }
//     for (var i = 0; i < 3; i++) {
//       var box1 = boxs.firstWhere(
//           (element) => element.rowindex == 0 && element.columnindex == i);
//       var box2 = boxs.firstWhere(
//           (element) => element.rowindex == 1 && element.columnindex == i);
//       var box3 = boxs.firstWhere(
//           (element) => element.rowindex == 2 && element.columnindex == i);
//       bool iseveryboxfilled = box1.currentpin != null &&
//           box2.currentpin != null &&
//           box3.currentpin != null;

//       if (iseveryboxfilled) {
//         bool isboxscurrentpinequal =
//             box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//                 box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//         if (isboxscurrentpinequal) winner = true;
//       }
//     }
//     var box1 = boxs.firstWhere(
//         (element) => element.rowindex == 0 && element.columnindex == 0);
//     var box2 = boxs.firstWhere(
//         (element) => element.rowindex == 1 && element.columnindex == 1);
//     var box3 = boxs.firstWhere(
//         (element) => element.rowindex == 2 && element.columnindex == 2);
//     bool iseveryboxfilled = box1.currentpin != null &&
//         box2.currentpin != null &&
//         box3.currentpin != null;

//     if (iseveryboxfilled) {
//       bool isboxscurrentpinequal =
//           box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//               box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//       if (isboxscurrentpinequal) winner = true;
//     }
//     box1 = boxs.firstWhere(
//         (element) => element.rowindex == 0 && element.columnindex == 2);
//     box2 = boxs.firstWhere(
//         (element) => element.rowindex == 1 && element.columnindex == 1);
//     box3 = boxs.firstWhere(
//         (element) => element.rowindex == 2 && element.columnindex == 0);
//     iseveryboxfilled = box1.currentpin != null &&
//         box2.currentpin != null &&
//         box3.currentpin != null;

//     if (iseveryboxfilled) {
//       bool isboxscurrentpinequal =
//           box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
//               box1.currentpin!.playerindex == box3.currentpin!.playerindex;
//       if (isboxscurrentpinequal) winner = true;
//     }
//     return winner;
//   }

//   checkfordraw(context, Socket socketClent) {
//     RoomDataProvider roomDataProvider =
//         Provider.of<RoomDataProvider>(context, listen: false);
//     var boxs = roomDataProvider.boxs;
//     // var currentplayer = roomDataProvider.;
//     var currentplayer = roomDataProvider.roomData['turn']['playerindex'];
//     bool draw = true;
//     var unselectedpins = roomDataProvider.pins.where((element) =>
//         (element.istricked == false && element.playerindex == currentplayer));
//     List<BoxModel> tempboxs = [];
//     for (var box in boxs) {
//       tempboxs.add(BoxModel(
//           rowindex: box.rowindex,
//           columnindex: box.columnindex,
//           currentpin: box.currentpin));
//       var boxpinindex;
//       if (box.currentpin != null) {
//         print(box.currentpin!.index);
//         boxpinindex = box.currentpin!.index;
//       } else {
//         boxpinindex = -1;
//       }
//       print(unselectedpins.length);
//       if (unselectedpins.isNotEmpty) {
//         for (var pin in unselectedpins) {
//           if (boxpinindex < pin.index) {
//             draw = false;
//           }
//         }
//       } else {
//         draw = true;
//       }
//     }
//     var tempcurrentplayer = roomDataProvider.roomData['turn']['playerindex'];
//     var player1untrickedpins = roomDataProvider.pins.where(
//         (element) => (element.istricked == false && element.playerindex == 0));
//     var player2untrickedpins = roomDataProvider.pins.where(
//         (element) => (element.istricked == false && element.playerindex == 1));

//     print(draw);
//     if (draw) {
//       showGameDialog(context, 'It is a draw');
//       // socketClent.emit('winner', {
//       //   'winnerSocketId': winner.socketID,
//       //   'roomId': roomDataProvider.roomData['_id'],
//       // });
//     }
//   }

//   void clearBoard(BuildContext context) {
//     RoomDataProvider roomDataProvider =
//         Provider.of<RoomDataProvider>(context, listen: false);
//     roomDataProvider.resetBoxs();
//     roomDataProvider.resetPins();
//   }
// }

import 'package:ontactoe/models/box_model.dart';
import 'package:ontactoe/models/pin_model.dart';
import 'package:ontactoe/models/position_model.dart';

class GameMethods {
  setBoxs() {
    List<BoxModel> boxs = [];
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        boxs.add(BoxModel(rowindex: j, columnindex: i));
      }
    }
    Map boxsmap = {};
    for (var i = 0; i < boxs.length; i++) {
      boxsmap.addAll({i: boxs[i].toJson()});
    }
    return boxsmap;
  }

  setPins() {
    List<PinModel> pins = [];
    for (var i = 0; i < 12; i++) {
      pins.add(PinModel(
          index: i < 6 ? i : i - 6,
          position: Position(
              left: i < 6 ? i * 50 : (i - 6) * 50, bottom: i < 6 ? 410 : 0),
          playerindex: i < 6 ? 0 : 1));
    }
    Map pinsmap = {};
    for (var i = 0; i < pins.length; i++) {
      pinsmap.addAll({i: pins[i].toJson()});
    }
    return pinsmap;
  }
}
