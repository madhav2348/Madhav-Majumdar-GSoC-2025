import 'dart:io';
import 'dart:math';

writeFile(String content) async {
  final filename = 'coordinate.dart';
  try {
    await File(filename).writeAsString(content, mode: FileMode.append);
  } catch (e) {
    throw Exception(e);
  }
}

String declare(int long, int from, int till, ) {
  // Unique ids = Unique();
  var command = [];
  int conditon = Random().nextInt(10);
  for (var i = 0; i < conditon; i++) {
    for (var j = from; j < till; j++) {
      int min = Random().nextInt(60);
      int sec = Random().nextInt(60);
      int afterSec = Random().nextInt(100);
      // id$id${ids.strings()} :
      // if (min < 9) {
      //   command +=
      //       '{ "latitude" : $j.0$min$sec$afterSec , "longitude" : $long.0$min$sec$afterSec}; \n';
      // } else if (sec < 9) {
      //   command +=
      //       '{ "latitude" : $j.${min}0$sec$afterSec , "longitude" : $long.${min}0$sec$afterSec}; \n';
      // } else if (afterSec < 9) {
      //   command +=
      //       '{ "latitude" : $j.$min${sec}0$afterSec , "longitude" : $long.$min${sec}0$afterSec}; \n';
      // } else {
      //   command +=
      //       '{ "latitude" : $j.$min$sec$afterSec , "longitude" : $long.$min$sec$afterSec}; \n';
      // }
      if (min <= 9) {
        command.add('${j + Random().nextInt(2)}.0$min$sec$afterSec');
      } else if (sec <= 9) {
        command.add('${j + Random().nextInt(2)}.${min}0$sec$afterSec');
      } else if (afterSec <= 9) {
        command.add('${j + Random().nextInt(2)}.$min${sec}0$afterSec');
      } else {
        command.add('${j + Random().nextInt(2)}.$min$sec$afterSec');
      }
    }
  }
  for (var i in command) {
    int min = Random().nextInt(60);
    int sec = Random().nextInt(60);
    int afterSec = Random().nextInt(100);
    // id$id${ids.strings()} :
    if (min <= 9) {
      command[command.indexOf(i)] =
          '<Placemark><Point><coordinates>${long + Random().nextInt(4) }.0$min$sec$afterSec, $i</coordinates></Point></Placemark> \n';
    } else if (sec <= 9) {
      command[command.indexOf(i)] =
          '<Placemark><Point><coordinates>${long + Random().nextInt(4)}.${min}0$sec$afterSec, $i</coordinates></Point></Placemark>\n';
    } else if (afterSec <= 9) {
      command[command.indexOf(i)] =
          '<Placemark><Point><coordinates>${long + Random().nextInt(4)}.$min${sec}0$afterSec, $i</coordinates></Point></Placemark> \n ';
    } else {
      command[command.indexOf(i)] =
          '<Placemark><Point><coordinates>${long + Random().nextInt(5)}.$min$sec$afterSec, $i</coordinates></Point></Placemark>  \n ';
    }
  }
  return command.join(' ');
}

generate() {
  var sum = 70;
  var all = '';
  for (var i = 1; i < 10; i++) {
    sum = sum + i;
    switch (sum) {
      case 71:
        all += declare(sum, 21, 28);
      case 72:
        all += declare(sum, 22, 28);
      case 73:
        all += declare(sum, 21, 29);
      case 74:
        all += declare(sum, 16, 30);
      case 75:
        all += declare(sum, 17, 35);
      case 76:
        all += declare(sum, 12, 35);
      case 77:
        all += declare(sum, 9, 35);
      case 78:
        continue;
      case 79:
        all += declare(sum, 11, 31);
      case 80:
        all += declare(sum, 17, 27);
      case 81:
        all += declare(sum, 18, 27);

      case 82:
        all += declare(sum, 16, 27);

      case 83:
        all += declare(sum, 18, 27);
      case 84:
        all += declare(sum, 19, 27);
        
      case 85:
        all += declare(sum, 20, 26);
      case 86:
        all += declare(sum, 11, 27);
        
      case 87:
        all += declare(sum, 22, 26);
      default:
        break;
    }
  }
  print("const allKml = $all ");
  writeFile('''  ${all.toString()}  ''');
}
