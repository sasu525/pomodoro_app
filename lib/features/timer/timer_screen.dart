import 'package:flutter/material.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポモドーロタイマー'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 作業か休憩かのラベル（今は固定）
            const Text(
              '作業中',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // タイマーの数字（今は固定）
            const Text(
              '25:00',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // ボタンを横に並べる
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 64,
                  color: Colors.deepOrange,
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: () {
                    // TODO: 後でスタート処理を書く
                    print('スタートボタンが押されました');
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 64,
                  color: Colors.grey,
                  icon: const Icon(Icons.pause_circle_filled),
                  onPressed: () {
                    // TODO: 後で一時停止処理を書く
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 64,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // TODO: 後でリセット処理を書く
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}