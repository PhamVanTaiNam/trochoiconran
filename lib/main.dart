
import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/body/game.dart';
import 'package:ktck_nguyen_hoang_phi_hung/data.dart';
import 'package:ktck_nguyen_hoang_phi_hung/layout/layout.dart';
import 'package:ktck_nguyen_hoang_phi_hung/login/login.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    // Vì sử dụng Provider, nó liên kết các widget với nhau chính vì vậy ở bậc cao nhất của
    // cây widged phải được bao bọc bởi MultiProvider
    MultiProvider(
      //Bằng cách sử dụng Provider và ChangeNotifierProvider,
      //các widget con có thể lắng nghe và cập nhật khi các đối tượng này thay đổi trạng thái,
      //giúp đồng bộ dữ liệu và giao diện người dùng trong ứng dụng Flutter.
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlayerInfo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

