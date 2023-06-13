
import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/login/login.dart';

class PlayerInfo extends ChangeNotifier {
  List<PlayData> playlist = [];

  void setPlay({
    required String player,
  }) {
    PlayData playData = PlayData(playerName: player);

    playlist.add(playData);

    notifyListeners();
  }
}

class PlayData {
  String playerName;

  PlayData({
    required this.playerName,
  });
}

