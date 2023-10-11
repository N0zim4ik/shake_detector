import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool a = false;

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  late ShakeDetector detector;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("ShakeDetector"),
            content: const Text("Shake boldi"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
    );
    detector.startListening();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => const A(
                          text: 'one Tap',
                        ));
              },
              child: const Text('Tap'),
            ),
            GestureDetector(
              onDoubleTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => const A(
                          text: 'double tap',
                        ));
              },
              child: const Text('Double Tap'),
            ),
            GestureDetector(
              onTap: () {
                int now = DateTime.now().millisecondsSinceEpoch;
                if (now - lastTap < 1000) {
                  consecutiveTaps++;
                  if (consecutiveTaps == 2) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const A(text: 'triple tap'));
                  }
                } else {
                  consecutiveTaps = 0;
                }
                lastTap = now;
              },
              child: const Text('Triple Tap'),
            )
          ],
        ),
      ),
    );
  }
}

class A extends StatelessWidget {
  const A({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: AlertDialog(title: Text(text), actions: const [
        Text('ok'),
      ]),
    );
  }
}


