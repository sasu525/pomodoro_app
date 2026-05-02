import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'timer_provider.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ① timerSeconds ではなく、TimerState（セット）全体を受け取る
    final timerState = ref.watch(timerProvider);

    final minutes = (timerState.remainingSeconds / 60).floor().toString().padLeft(2, '0');
    final seconds = (timerState.remainingSeconds % 60).toString().padLeft(2, '0');

    // ② 今のモードが「作業中」かどうかを判定
    final isWorkMode = timerState.mode == TimerMode.work;
    
    // ③ モードによって表示する文字と色を変える！
    final modeText = isWorkMode ? '作業中' : '休憩中';
    final themeColor = isWorkMode ? Colors.deepOrange : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポモドーロタイマー'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              modeText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeColor, // 文字の色も連動させる
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$minutes:$seconds',
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 64,
                  color: themeColor, // ボタンの色も連動させる
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: () {
                    ref.read(timerProvider.notifier).start();
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 64,
                  color: Colors.grey,
                  icon: const Icon(Icons.pause_circle_filled),
                  onPressed: () {
                    ref.read(timerProvider.notifier).pause();
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 64,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    ref.read(timerProvider.notifier).reset();
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