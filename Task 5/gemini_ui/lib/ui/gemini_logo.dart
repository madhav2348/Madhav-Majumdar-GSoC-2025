import 'package:flutter/material.dart';
import 'package:rive/math.dart';
import 'package:rive/rive.dart';

// // class GeminiLogo extends StatefulWidget {
// //   const GeminiLogo({super.key});

// //   @override
// //   State<GeminiLogo> createState() => _GeminiLogoState();
// // }

// // class _GeminiLogoState extends State<GeminiLogo> {
// //   SMITrigger? _tapTrigger;
// //   Artboard? _artboard;

// //   void _loadRiveFile() async {
// //     final data = await RiveFile.asset('assets/gemini.riv');
// //     // final file = RiveFile.import(data);
// //     final artboard = data.mainArtboard;

// //     final controller = StateMachineController.fromArtboard(
// //       artboard,
// //       'StateMachineName', // Replace with your state machine name
// //     );

// //     if (controller != null) {
// //       artboard.addController(controller);
// //       _tapTrigger = controller.findInput<SMITrigger>('Tap') as SMITrigger; // Input name in Rive
// //     }

// //     setState(() => _artboard = artboard);
// //   }

// //   void _onTap() {
// //     _tapTrigger?.fire();
// //   }

  
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadRiveFile();
// //   }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: GestureDetector(
// //           onTap: _onTap,
// //           child: _artboard == null
// //               ? const SizedBox()
// //               : Rive(artboard: _artboard!),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// class GeminiLogo extends StatefulWidget {
//   const GeminiLogo({super.key});

//   @override
//   State<GeminiLogo> createState() => _GeminiLogoState();
// }

// class _GeminiLogoState extends State<GeminiLogo> {
// late  RiveAnimationController _controller ;

//   SMITrigger? _tapTrigger;
//   Artboard? _artboard;

//   void _loadRiveFile() async {
//     final data = await RiveFile.asset('assets/gemini.riv');
//   //   // final file = RiveFile.import(data);
//     final artboard = data.mainArtboard;

//     final _controller = StateMachineController.fromArtboard(
//       artboard,
//       'State Machine Name', // Replace with your state machine name
//     );

//     if (_controller != null) {
//       artboard.addController(_controller);
//       _tapTrigger = _controller.findInput<SMITrigger>('Tap') as SMITrigger; // Input name in Rive
//     }

//     setState(() => _artboard = artboard);
//   }

//   void _onTap() {
//     _tapTrigger?.fire();
//   }
//    @override
//   void initState() {
//     super.initState();
//     // _controller =StateMachineController()
//     _loadRiveFile();

//     _controller = SimpleAnimation(
//       "active",
//       autoplay: true,
//     );
//       _controller = OneShotAnimation('active', autoplay: true);

//   }

  
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _loadRiveFile();
//   // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           // onTap: _onTap,
//           onTap:()=> _controller.isActive,
         
//           child:  RiveAnimation.asset('assets/gemini.riv' ,controllers: [_controller],),
//         ),
//       ),
//     );
//   }
// }



class GeminiLogo extends StatefulWidget {
const GeminiLogo({super.key});

@override
State<GeminiLogo> createState() => _GeminiLogoState();
}

class _GeminiLogoState extends State<GeminiLogo> {
late StateMachineController _controller;

@override
void initState() {
    super.initState();
}

String ratingValue = 'Rating: 0';

void onInit(Artboard artboard) async {
    _controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1')!;
    artboard.addController(_controller);

    _controller.addEventListener(onRiveEvent);
}

void onRiveEvent(RiveEvent event) {
    // Access custom properties defined on the event
    var rating = event.properties['rating'] as double;
    // Schedule the setState for the next frame, as an event can be
    // triggered during a current frame update
    WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
        ratingValue = '$rating';
    });
    });
}

@override
void dispose() {
    _controller.removeEventListener(onRiveEvent);
    _controller.dispose();
    super.dispose();
}

@override
Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text('Gemini Logo'),
    ),
    body: Column(
        children: [
        Expanded(
            child: RiveAnimation.asset(
            'assets/gemini.riv',
            onInit: onInit,
            ),
        ),
        
        ],
    ),
    );
}
}