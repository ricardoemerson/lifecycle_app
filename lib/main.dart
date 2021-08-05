import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexColorScheme.light(scheme: FlexScheme.indigo).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.indigo).toTheme,
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Timer timer;
  int count = 0;
  bool active = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active) {
        setState(() {
          count += 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      active = true;
      print('Resumed');
    } else if (state == AppLifecycleState.inactive) {
      active = false;
      print('Inactive');
    } else if (state == AppLifecycleState.detached) {
      print('Detached');
    } else if (state == AppLifecycleState.paused) {
      active = false;
      print('Paused');
    }
  }

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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
