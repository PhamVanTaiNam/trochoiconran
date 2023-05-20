import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Game',
      home: HomePage(),
    );
  }
}

class HomePageO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/start_button.png',
                width: 200,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('START'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Myapp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<int> snakePostion = [45, 65, 85, 105, 125];
  int numberOfSquares = 760;

  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  void generateNewFood() {
    food = randomNumber.nextInt(700);
  }

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

  var direction = 'down';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePostion.last > 740) {
            snakePostion.add(snakePostion.last + 20 - 760);
          } else {
            snakePostion.add(snakePostion.last + 20);
          }

          break;

        case 'up':
          if (snakePostion.last < 20) {
            snakePostion.add(snakePostion.last - 20 + 760);
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
                new Text('You\'re score: ' + snakePostion.length.toString()),
            actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar : AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
                  onVerticalDragUpdate: ((details) {
                    if (direction != 'up' && details.delta.dy > 0) {
                      direction = 'down';
                    } else if (direction != 'down' && details.delta.dy < 0) {
                      direction = 'up';
                    }
                  }),
                  onHorizontalDragUpdate: (details) {
                    if (direction != 'left' && details.delta.dx > 0) {
                      direction = 'right';
                    } else if (direction != 'right' && details.delta.dx < 0) {
                      direction = 'left';
                    }
                  },
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
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (index == food) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(color: Colors.green),
                              ),
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(color: Colors.grey[900]),
                              ),
                            );
                          }
                        }),
                  ))),
          Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: startGame,
                        child: Text(
                          's t a r t',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    Text(
                      ' @ n a m p h a n v a n t a i: ' +
                          snakePostion.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ]))
        ],
      ),
    );
  }
}
