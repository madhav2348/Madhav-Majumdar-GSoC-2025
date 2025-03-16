import 'dart:async';

import 'package:flutter/material.dart';

import 'package:record/record.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool is_start = false;
  double _changeValue = 1;
  // StateMachineController? _controller;

  Artboard? _riveArtboard;
  SMINumber? _levelInput;
  SMIBool? _boo;

  double convertDbToRange(double db, {double minDb = -100, double maxDb = 0}) {
    db = db.clamp(minDb, maxDb);
    return (((db - minDb) / (maxDb - minDb)) * 9 + 1);
  }

  Future<void> _start() async {
    if (await _audioRecorder.hasPermission()) {
      const encoder = AudioEncoder.aacEld;
      if (!await _audioRecorder.isEncoderSupported(encoder)) {
        return;
      }
      const config = RecordConfig(encoder: encoder, numChannels: 1);
      await _audioRecorder.startStream(config);

      _audioRecorder
          .onAmplitudeChanged(const Duration(milliseconds: 100))
          .listen((amp) {
            setState(() {
              _changeValue = convertDbToRange(amp.current);
              print('${convertDbToRange(amp.current)}');
              _levelInput!.value = convertDbToRange(amp.current);
              _boo!.change(!is_start);
              print(_levelInput);
            });
          });
    }
  }

  Future<void> _stop() async {
    await _audioRecorder.stop();
    _audioRecorder.dispose();
    setState(() {
      _changeValue = 1;
    });
  }

  // Future<void> _onInit() async {
  //   try {
  //     final file = await RiveFile.asset('assets/assistance.riv');
  //     var artboard = file.artboardByName('Artboard')!;
  //     final _controller = StateMachineController.fromArtboard(
  //       artboard,
  //       'State Machine 1',
  //     );
  //     print(file);
  //     print(artboard);
  //     print(_controller);
  //     if (_controller != null) {
  //       artboard.addController(_controller);
  //       _levelInput =  _controller.getNumberInput('Number');
  //       print(_levelInput);
  //       _boo = _controller.getBoolInput('Boolean 1');
  //       print(_boo);
  //     }

  //     setState(() {
  //       _riveArtboard = artboard;

  //     });
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  void initState() {
    // _onInit();
    print('stsrt');

    print('222st00');
    super.initState();
    print('33t');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _start,
              child: SizedBox(
                width: 350,
                height: 500,
                child: RiveAnimation.asset(
                  'assets/assist.riv',
                  artboard: 'Artboard',
                  // stateMachines: ['State Machine 1'],
                  // speedMultiplier: _changeValue,
                  fit: BoxFit.contain,
                  onInit: (artboard) {
                    StateMachineController controller =
                        StateMachineController.fromArtboard(
                          artboard,
                          'State Machine 1',
                        )!;
                    _boo = controller.findInput('Boolean 1') as SMIBool;
                    _levelInput = controller.findInput('Number') as SMINumber;
                  },
                ),
              ),
            ),

            SizedBox(width: 15),
            SizedBox(
              width: 100,
              height: 100,
              child: ElevatedButton(
                // onPressed: () => _stopRecording(),
                onPressed: () {
                  setState(() {
                    is_start = !is_start;
                  });
                  is_start ? _start() : _stop();
                },
                child:
                    is_start == true
                        ? const Icon(Icons.play_arrow, size: 50)
                        : const Icon(Icons.pause, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
