import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _elapsedTime = '00:00.00';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 10), _updateTime);
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds / (1000 * 60)).truncate();
    int seconds = ((milliseconds / 1000) % 60).truncate();
    int hundredths = ((milliseconds / 10) % 100).truncate();

    return '$minutes:${seconds.toString().padLeft(2, '0')}.${hundredths.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _elapsedTime,
              style: TextStyle(fontSize: 40.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_stopwatch.isRunning) {
                        _stopwatch.stop();
                      } else {
                        _stopwatch.start();
                      }
                    });
                  },
                  child: Text(_stopwatch.isRunning ? 'Pause' : 'Start'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _stopwatch.reset();
                      _elapsedTime = '00:00.00';
                    });
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

