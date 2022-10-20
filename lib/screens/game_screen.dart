import 'dart:math';

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../models/box_model.dart';
import '../models/pin_model.dart';
import '../models/position_model.dart';
import '../widgets/pin.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<PinModel> pins = [];
  PinModel? selectedpin;
  List<BoxModel> boxs = [];

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpins();
    initboxs();
    _createInterstitialAd();
  }

  initpins() {
    for (var i = 0; i < 12; i++) {
      pins.add(PinModel(
          index: i < 6 ? i : i - 6,
          position: Position(
              left: i < 6 ? i * 50 : (i - 6) * 50, bottom: i < 6 ? 410 : 0),
          playerindex: i < 6 ? 0 : 1));
    }
    setState(() {});
  }

  initboxs() {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        boxs.add(BoxModel(rowindex: j, columnindex: i));
      }
    }
    setState(() {});
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              ElevatedButton(
                child: Text("Play Again"),
                onPressed: () {
                  _restart();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _restart() {
    _showInterstitialAd();
    _createInterstitialAd();
    pins.clear();
    boxs.clear();
    selectedpin = null;
    initpins();
    initboxs();
    setState(() {});
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  int maxFailedLoadAttempts = 3;
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  checkforwinner() {
    for (var i = 0; i < 3; i++) {
      var box1 = boxs.firstWhere(
          (element) => element.rowindex == i && element.columnindex == 0);
      var box2 = boxs.firstWhere(
          (element) => element.rowindex == i && element.columnindex == 1);
      var box3 = boxs.firstWhere(
          (element) => element.rowindex == i && element.columnindex == 2);
      bool iseveryboxfilled = box1.currentpin != null &&
          box2.currentpin != null &&
          box3.currentpin != null;

      if (iseveryboxfilled) {
        bool isboxscurrentpinequal =
            box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
                box1.currentpin!.playerindex == box3.currentpin!.playerindex;
        if (isboxscurrentpinequal)
          _showWinDialog(
              'player' + (box3.currentpin!.playerindex + 1).toString());
      }
    }
    for (var i = 0; i < 3; i++) {
      var box1 = boxs.firstWhere(
          (element) => element.rowindex == 0 && element.columnindex == i);
      var box2 = boxs.firstWhere(
          (element) => element.rowindex == 1 && element.columnindex == i);
      var box3 = boxs.firstWhere(
          (element) => element.rowindex == 2 && element.columnindex == i);
      bool iseveryboxfilled = box1.currentpin != null &&
          box2.currentpin != null &&
          box3.currentpin != null;

      if (iseveryboxfilled) {
        bool isboxscurrentpinequal =
            box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
                box1.currentpin!.playerindex == box3.currentpin!.playerindex;
        if (isboxscurrentpinequal)
          _showWinDialog(
              'player' + (box3.currentpin!.playerindex + 1).toString());
      }
    }
    var box1 = boxs.firstWhere(
        (element) => element.rowindex == 0 && element.columnindex == 0);
    var box2 = boxs.firstWhere(
        (element) => element.rowindex == 1 && element.columnindex == 1);
    var box3 = boxs.firstWhere(
        (element) => element.rowindex == 2 && element.columnindex == 2);
    bool iseveryboxfilled = box1.currentpin != null &&
        box2.currentpin != null &&
        box3.currentpin != null;

    if (iseveryboxfilled) {
      bool isboxscurrentpinequal =
          box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
              box1.currentpin!.playerindex == box3.currentpin!.playerindex;
      if (isboxscurrentpinequal)
        _showWinDialog(
            'player' + (box3.currentpin!.playerindex + 1).toString());
    }
    box1 = boxs.firstWhere(
        (element) => element.rowindex == 0 && element.columnindex == 2);
    box2 = boxs.firstWhere(
        (element) => element.rowindex == 1 && element.columnindex == 1);
    box3 = boxs.firstWhere(
        (element) => element.rowindex == 2 && element.columnindex == 0);
    iseveryboxfilled = box1.currentpin != null &&
        box2.currentpin != null &&
        box3.currentpin != null;

    if (iseveryboxfilled) {
      bool isboxscurrentpinequal =
          box1.currentpin!.playerindex == box2.currentpin!.playerindex &&
              box1.currentpin!.playerindex == box3.currentpin!.playerindex;
      if (isboxscurrentpinequal)
        _showWinDialog(
            'player' + (box3.currentpin!.playerindex + 1).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: IconButton(
                        onPressed: () => _restart(),
                        icon: Icon(
                          Icons.replay_rounded,
                          size: 40,
                        )),
                  )
                ],
              ),
              Text(
                'Player 1',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              Container(
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
                                      var currentpin = boxs
                                          .firstWhere((element) =>
                                              element.columnindex == j &&
                                              element.rowindex == i)
                                          .currentpin;

                                      if (selectedpin != null) {
                                        if (currentpin == null ||
                                            currentpin.index <
                                                selectedpin!.index) {
                                          selectedpin!.position!.left =
                                              28 + (j * 100);
                                          selectedpin!.position!.bottom =
                                              10 + ((3 - i) * 100);
                                          pins[selectedpin!.index +
                                                  (6 *
                                                      selectedpin!.playerindex)]
                                              .istricked = true;
                                          pins[selectedpin!.index +
                                                  (6 *
                                                      selectedpin!.playerindex)]
                                              .isselected = false;
                                          boxs
                                              .firstWhere((element) =>
                                                  element.columnindex == j &&
                                                  element.rowindex == i)
                                              .currentpin = selectedpin;

                                          selectedpin = null;
                                          // for (var box in boxs) {
                                          //   if (box.currentpin != null)
                                          //     print(box.currentpin!.playerindex);
                                          // }
                                        } else {
                                          pins[selectedpin!.index +
                                                  (6 *
                                                      selectedpin!.playerindex)]
                                              .isselected = false;
                                          selectedpin = null;
                                        }
                                      }
                                      setState(() {});
                                      checkforwinner();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              bottom: i != 2
                                                  ? BorderSide(
                                                      color: Colors.black,
                                                      width: 2)
                                                  : BorderSide.none,
                                              right: j != 2
                                                  ? BorderSide(
                                                      color: Colors.black,
                                                      width: 2)
                                                  : BorderSide.none)),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < 6; i++)
                      for (int j = 0; j < 2; j++)
                        AnimatedPositioned(
                            left: pins[i + (j * 6)].position!.left,
                            bottom: pins[i + (j * 6)].isselected
                                ? pins[i + (j * 6)].position!.bottom! + 10
                                : pins[i + (j * 6)].position!.bottom!,
                            duration: Duration(milliseconds: 200),
                            child: IgnorePointer(
                              ignoring: pins[i + (j * 6)].istricked,
                              child: InkWell(
                                  onTap: () {
                                    if (selectedpin != pins[i + (j * 6)] &&
                                        !pins[i + (j * 6)].istricked) {
                                      if (selectedpin != null)
                                        selectedpin!.isselected = false;
                                      selectedpin = pins[i + (j * 6)];
                                      pins[i + (j * 6)].isselected = true;
                                    } else {
                                      selectedpin = null;
                                      pins[i + (j * 6)].isselected = false;
                                    }

                                    setState(() {});
                                  },
                                  child: Pin(
                                      height: 40.00 + i * 7,
                                      color:
                                          j == 0 ? Colors.red : Colors.blue)),
                            )),
                  ],
                ),
              ),
              Text(
                'Player 2',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
