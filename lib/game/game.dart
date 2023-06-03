
import 'package:flutter/material.dart';

import 'package:ktck_nguyen_hoang_phi_hung/data.dart';
import 'package:ktck_nguyen_hoang_phi_hung/layout/layout.dart';
import 'dart:async';
import 'dart:math';
import 'package:ktck_nguyen_hoang_phi_hung/main.dart';
import 'package:provider/provider.dart';
import 'package:ktck_nguyen_hoang_phi_hung/login/login.dart';

void main() => runApp(MyApp());

class Game extends StatefulWidget {
  Game({super.key});

  @override
  State<Game> createState() => _homeGame();
}

class _homeGame extends State<Game> {
  static List<int> snakePostion = [45, 65, 85, 105, 125];
  // vị trí khởi đầu của rắn
  int numberOfSquares = 660;
//số ô
  static var randomNumber = Random();
  int food = randomNumber.nextInt(660);
  void generateNewFood() {
    food = randomNumber.nextInt(600);
  }

// vị trí ngẫu nhiên của đồ ăn
  void startGame() {
    snakePostion = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();

      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }
// game bắt đàu thì tạo ra rắn , tốc độ,
// nếu game két thúc  thì rắn ngưng chạy và show ra màn hình kết quả điểm

  var phuongHuong = 'down';
  void updateSnake() {
    setState(() {
      switch (phuongHuong) {
        case 'down':
          if (snakePostion.last > 640) {
            snakePostion.add(snakePostion.last + 20 - 660);
          } else {
            snakePostion.add(snakePostion.last + 20);
          }
          break;

        case 'up':
          if (snakePostion.last < 20) {
            snakePostion.add(snakePostion.last - 20 + 660);
          } else {
            snakePostion.add(snakePostion.last - 20);
          }
          break;

        case 'left':
          if (snakePostion.last % 20 == 0) {
            snakePostion.add(snakePostion.last - 1 + 20);
          } else {
            snakePostion.add(snakePostion.last - 1);
          }
          break;

        case 'right':
          if (snakePostion.last % 20 == 0) {
            snakePostion.add(snakePostion.last + 1 - 20);
          } else {
            snakePostion.add(snakePostion.last + 1);
          }
          break;

        default:
      }
      if (snakePostion.last == food) {
        generateNewFood();
      } else {
        snakePostion.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePostion.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePostion.length; j++) {
        if (snakePostion[i] == snakePostion[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Game Over'),
            content:
                new Text('Điểm của bạn là: ' + snakePostion.length.toString()),
            actions: <Widget>[
              new ElevatedButton(
                child: Text('Transcript'),
                onPressed: () {
                  _bangDiem();
                },
              ),
              new TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _bangDiem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Bảng điểm'),
            content: new Text('Phi Hùng:    ' + snakePostion.length.toString()),
            actions: <Widget>[
              new TextButton(
                child: Text('Back'),
                onPressed: () {
                  Layout();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    PlayerInfo playerInfo = Provider.of<PlayerInfo>(context);
    return Scaffold(
      //appBar : AppBar(),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
                  onVerticalDragUpdate: ((details) {
                    if (phuongHuong != 'up' && details.delta.dy > 0) {
                      phuongHuong = 'down';
                    } else if (phuongHuong != 'down' && details.delta.dy < 0) {
                      phuongHuong = 'up';
                    }
                  }),
                  onHorizontalDragUpdate: (details) {
                    if (phuongHuong != 'left' && details.delta.dx > 0) {
                      phuongHuong = 'right';
                    } else if (phuongHuong != 'right' && details.delta.dx < 0) {
                      phuongHuong = 'left';
                    }
                  },
                  //giao diện màn hình và cử chỉ của ng chơi
                  child: Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfSquares,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                        itemBuilder: (BuildContext context, int index) {
                          if (snakePostion.contains(index)) {
                            return Center(
                              child: Container(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Color.fromARGB(255, 0, 255, 34),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (index == food) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                              ),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Container(color: Colors.grey[900]),
                              ),
                            );
                          }
                        }),
                  ))),
          // giao diện của răn , đồ ăn và ô
          Padding(
              padding:
                  const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: startGame,
                        child: Text(
                          'Start',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              backgroundColor: Colors.white),
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: playerInfo.playlist.length,
                        itemBuilder: (context, index) {
                          PlayData playData = playerInfo.playlist[index];
                          return Text(
                            'Xin chào' + playData.playerName,
                            style: TextStyle(
                                backgroundColor: Colors.black,
                                color: Colors.white,
                                fontSize: 20),
                          );
                        },
                      ),
                    ),
                    Text(
                      'Điểm: ' + snakePostion.length.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          backgroundColor: Colors.white),
                    )
                  ]))
        ],
      ),
    );
  }
  // dòng chứ start và điểm
}
