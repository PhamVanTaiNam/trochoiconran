import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/body/game.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _homeLayout();
}

class _homeLayout extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: const EdgeInsets.all(50),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ran1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Color.fromARGB(255, 0, 0, 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game()),
                );
              },
              icon: const Icon(Icons.play_circle),
              iconSize: 100,
            ),
          ],
        ),
      ),
    );
  }
}
