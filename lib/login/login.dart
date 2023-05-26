import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/layout/layout.dart';
import 'package:ktck_nguyen_hoang_phi_hung/login/login.dart';
import 'package:provider/provider.dart';
import '../data.dart';

class Login extends StatelessWidget {
  // final List<String> username = [];
  final TextEditingController _username = TextEditingController();

  final userName = PlayData(playerName: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 185, 31),
        title: const Text('Đăng nhập'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _username,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Username',
                  hintText: 'Enter Username'),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter password',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility),
                  )),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String playerName = _username.text;
                List<PlayData> playlist =
                    Provider.of<PlayerInfo>(context, listen: false).playlist;
                PlayData playData = PlayData(playerName: playerName);

                playlist.add(playData);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Layout()));
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
