import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


class SearchDebouncer<T> {
  SearchDebouncer(this.duration, this.onValue);

  final Duration duration;
  void Function(T? value) onValue;
  T? _value;
  Timer? _timer;

  T? get value => _value;

  set value(T? val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}