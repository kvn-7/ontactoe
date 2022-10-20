import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pin_model.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<RoomDataProvider>(context, listen: false).initBoxs();
    // Provider.of<RoomDataProvider>(context, listen: false).initPins();
    // _socketMethods.trickedListener(context);
  }

  PinModel? selectedpin;
  // final SocketMethods _socketMethods = SocketMethods();

  @override
  Widget build(BuildContext context) {
    // RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    // var player1Color = colors.entries
    //     .firstWhere(
    //       (element) => element.key == roomDataProvider.player1.color,
    //     )
    //     .value;
    // var player2Color = colors.entries
    //     .firstWhere(
    //       (element) => element.key == roomDataProvider.player2.color,
    //     )
    //     .value;
    return Container(
      height: 500,
      width: 300,
      child: Stack(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < 3; j++)
                        InkWell(
                          onTap: () {
                            // var currentpin = roomDataProvider.boxs
                            //     .firstWhere((element) =>
                            //         element.columnindex == j &&
                            //         element.rowindex == i)
                            //     .currentpin;
                            // var box = roomDataProvider.boxs.firstWhere(
                            //     (element) =>
                            //         element.columnindex == j &&
                            //         element.rowindex == i);
                            // if (selectedpin != null) {
                            //   if (currentpin == null ||
                            //       currentpin.index < selectedpin!.index) {
                            //     _socketMethods.tapGrid(selectedpin!, box,
                            //         roomDataProvider.roomData['_id']);
                            //     selectedpin = null;
                            //   } else {
                            //     roomDataProvider
                            //         .pins[selectedpin!.index +
                            //             (6 * selectedpin!.playerindex)]
                            //         .isselected = false;
                            //     selectedpin = null;
                            //   }
                            // }
                            // setState(() {});
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: i != 2
                                        ? BorderSide(
                                            color: Colors.black, width: 2)
                                        : BorderSide.none,
                                    right: j != 2
                                        ? BorderSide(
                                            color: Colors.black, width: 2)
                                        : BorderSide.none)),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          // for (int i = 0; i < 6; i++)
          //   for (int j = 0; j < 2; j++)
          // AnimatedPositioned(
          //     left: roomDataProvider.pins[i + (j * 6)].position!.left,
          //     bottom: roomDataProvider.pins[i + (j * 6)].isselected
          //         ? roomDataProvider.pins[i + (j * 6)].position!.bottom! +
          //             10
          //         : roomDataProvider.pins[i + (j * 6)].position!.bottom!,
          //     duration: Duration(milliseconds: 200),
          //     child: IgnorePointer(
          //       ignoring: roomDataProvider.pins[i + (j * 6)].istricked ||
          //           roomDataProvider.roomData['turn']['socketID'] !=
          //               _socketMethods.socketClient.id ||
          //           roomDataProvider.roomData['turn']['playerindex'] != j,
          //       child: InkWell(
          //           onTap: () {
          //             if (selectedpin !=
          //                     roomDataProvider.pins[i + (j * 6)] &&
          //                 !roomDataProvider.pins[i + (j * 6)].istricked) {
          //               if (selectedpin != null)
          //                 selectedpin!.isselected = false;
          //               selectedpin = roomDataProvider.pins[i + (j * 6)];
          //               roomDataProvider.pins[i + (j * 6)].isselected =
          //                   true;
          //             } else {
          //               selectedpin = null;
          //               roomDataProvider.pins[i + (j * 6)].isselected =
          //                   false;
          //             }

          //             setState(() {});
          //           },
          //           child: Pin(
          //               height: 40.00 + i * 7,
          //               color: j == 0 ? player1Color : player2Color)),
          //     )),
        ],
      ),
    );
  }
}
