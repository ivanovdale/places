import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstStatefulWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}

class MyFirstWidget extends StatelessWidget {
  int _buildCounter = 0;

  MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildCounter++;

    if (kDebugMode) {
      print('Build method. Count of builds: $_buildCounter');
    }

    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}

class MyFirstStatefulWidget extends StatefulWidget {

  MyFirstStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyFirstStatefulWidget> createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  int _buildCounter = 0;

  @override
  Widget build(BuildContext context) {
    _buildCounter++;

    if (kDebugMode) {
      print('Build method. Count of builds: $_buildCounter');
    }

    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
