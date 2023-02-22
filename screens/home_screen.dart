import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinuates = 1500;
  bool isRunning = false;
  int totalSecond = twentyFiveMinuates;
  late Timer timer;
  int totalPompdoro = 0;

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 7);
  }

  void onTik(Timer timer) {
    setState(() {
      totalSecond = totalSecond - 1;
      if (totalSecond == 0) {
        totalSecond = 2;
        totalPompdoro += 1;
        onPausePress();
      }
    });
  }

  void onStartedPress() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTik,
    );
    setState(() {
      isRunning = !isRunning;
    });
  }

  void onPausePress() {
    timer.cancel();
    isRunning = !isRunning;
    setState(() {});
  }

  void onStopPress() {
    timer.cancel();
    isRunning = false;
    totalSecond = twentyFiveMinuates;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecond),
                style:
                    TextStyle(fontSize: 89, color: Theme.of(context).cardColor),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePress : onStartedPress,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline_outlined
                        : Icons.play_circle_fill_outlined),
                  ),
                  IconButton(
                      color: Theme.of(context).cardColor,
                      iconSize: 80,
                      onPressed: onStopPress,
                      icon: const Icon(Icons.stop_circle_outlined))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoro',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                        Text(
                          '$totalPompdoro',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
