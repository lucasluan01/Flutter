// flutter pub run build_runner watch

import 'package:mobx/mobx.dart';

part "counter.g.dart";
class Counter = _Counter with _$Counter;

abstract class _Counter with Store {
  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }
}
