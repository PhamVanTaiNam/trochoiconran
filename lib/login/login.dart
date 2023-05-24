import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/layout/layout.dart';
import 'package:ktck_nguyen_hoang_phi_hung/login/login.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Đăng nhập'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
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
