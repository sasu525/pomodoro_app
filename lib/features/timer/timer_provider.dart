import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ① モードを表す「列挙型（Enum）」を作成
enum TimerMode {
  work, // 作業中
  rest, // 休憩中
}

// ② タイマーの「状態」をセットで管理するクラス
class TimerState {
  final int remainingSeconds; // 残り秒数
  final TimerMode mode;       // 今のモード（作業か休憩か）

  TimerState({
    required this.remainingSeconds,
    required this.mode,
  });
}

// ③ 脳みそ本体。管理するデータが「int（数字）」から「TimerState（セット）」に変わりました！
class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;

  // 25分と5分を秒数で定義しておく
  static const int workSeconds = 1 * 60;
  static const int restSeconds = 5 * 60;

  @override
  TimerState build() {
    // 最初は「作業中」の「25分」でスタートします
    return TimerState(remainingSeconds: workSeconds, mode: TimerMode.work);
  }

  void start() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        // 残り秒数を1減らし、モードはそのまま維持する
        state = TimerState(
          remainingSeconds: state.remainingSeconds - 1,
          mode: state.mode,
        );
      } else {
        // 0秒になったらタイマーを止めて、モードを切り替える！
        timer.cancel();
        _switchMode();
      }
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void reset() {
    _timer?.cancel();
    // 今のモードに合わせて初期値に戻す
    final resetSeconds = state.mode == TimerMode.work ? workSeconds : restSeconds;
    state = TimerState(remainingSeconds: resetSeconds, mode: state.mode);
  }

  // ④ モードを切り替える裏技関数
  void _switchMode() {
    if (state.mode == TimerMode.work) {
      // 作業 → 休憩へ
      state = TimerState(remainingSeconds: restSeconds, mode: TimerMode.rest);
    } else {
      // 休憩 → 作業へ
      state = TimerState(remainingSeconds: workSeconds, mode: TimerMode.work);
    }
  }
}

// ⑤ プロバイダーも TimerState を扱うように変更
final timerProvider = NotifierProvider<TimerNotifier, TimerState>(() {
  return TimerNotifier();
});