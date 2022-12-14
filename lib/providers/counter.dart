import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old.value != _value;
  }
}
/// the class bellow is apart of a practice of Inherited Widgets it doesn't add anything to the actual app
class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({required Widget child}) : super(child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget){
    return oldWidget.state.diff(state);
  }

}