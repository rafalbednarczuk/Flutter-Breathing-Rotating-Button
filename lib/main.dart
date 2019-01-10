import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _breathingController;
  var _breathe = 0.0;
  AnimationController _angleController;
  var _angle = 0.0;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });
    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
    _breathingController.forward();

    _angleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _angleController.addListener(() {
      setState(() {
        _angle = _angleController.value * 45 / 360 * 2 * pi;
      });
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 - 20.0 * _breathe;
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: _buttonTap,
        child: Container(
          width: size,
          height: size,
          child: Transform.rotate(
            angle: 45 / 360 * pi * 2,
            child: Material(
              borderRadius: BorderRadius.circular(size / 3),
              color: Colors.pinkAccent,
              child: Transform.rotate(
                angle: _angle,
                child: Icon(
                  Icons.clear,
                  size: size,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void _buttonTap() {
    if (_angleController.status == AnimationStatus.completed) {
      _angleController.reverse();
    } else if (_angleController.status == AnimationStatus.dismissed) {
      _angleController.forward();
    }
  }
}
