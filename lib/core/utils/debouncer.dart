import 'dart:async';

/// A utility class for debouncing function calls
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// Run the action after the delay
  /// If called again before delay expires, the timer resets
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel any pending action
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Check if there's a pending action
  bool get isPending => _timer?.isActive ?? false;

  /// Dispose the debouncer
  void dispose() {
    cancel();
  }
}

/// A utility class for throttling function calls
class Throttler {
  final Duration delay;
  Timer? _timer;
  bool _isThrottled = false;

  Throttler({this.delay = const Duration(milliseconds: 300)});

  /// Run the action immediately, then ignore subsequent calls until delay expires
  void run(void Function() action) {
    if (_isThrottled) return;

    action();
    _isThrottled = true;

    _timer?.cancel();
    _timer = Timer(delay, () {
      _isThrottled = false;
    });
  }

  /// Cancel any pending throttle
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }

  /// Check if currently throttled
  bool get isThrottled => _isThrottled;

  /// Dispose the throttler
  void dispose() {
    cancel();
  }
}
