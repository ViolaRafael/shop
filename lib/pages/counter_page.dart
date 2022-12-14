import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

/// the class bellow is apart of a practice of Inherited Widgets it doesn't add anything to the actual app
class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

/// the class bellow is apart of a practice of Inherited Widgets it doesn't add anything to the actual app
class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo Contador'),
      ),
      body: Column(
        children: [
          Text(CounterProvider.of(context)?.state.value.toString() ?? '0'),
          IconButton(
            onPressed: () {
              setState(() {
              CounterProvider.of(context)?.state.inc();
              });
              print(CounterProvider.of(context)?.state.value);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
              CounterProvider.of(context)?.state.dec();
              });
              print(CounterProvider.of(context)?.state.value);
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
