import 'dart:async';

import 'package:lg_example/model/kml.dart';
import 'package:lg_example/model/kml_send.dart';
import 'package:lg_example/service/ssh_service.dart';
import 'package:lg_example/showtoast.dart';

class LGConnection {
  final ssh = SSHService();
  bool _established = false;
  bool get establish => _established;

  final String _url = '\nhttp://lg1:81';

  Future sendToLG() async {
    //String kml
    try {
      await ssh.connectToserver();
      await sendKMLToSlave(3, SendKML.sendlogo('slave_3'));

      showToast('Logo Sended');
    } catch (e) {
      showToast('Something went wrong');

      throw Exception(e);
    }
  }

  Future<void> sendKMLToSlave(int screen, String content) async {
    try {
      await ssh.connectToserver();
      await ssh.execute(
        'echo \'$content\' > /var/www/html/kml/slave_$screen.kml',
      );
    } catch (e) {
      showToast('Something went wrong $e');
      throw Exception();
    }
  }

   Future<void> sendKml(
    KML kml,
    // {List<Map<String, String>> images = const [],} // not using because we are just send kml not images
  ) async {
    final fileName = '${kml.name}.kml';

    try {
      await ssh.connectToserver();
      await ssh.execute('echo \'${kml.fileKML}\' > /var/www/html/$fileName');

      await ssh.execute('echo "$_url/$fileName" > /var/www/html/kmls.txt');
      showToast('KML Send');
    } catch (e) {
      showToast('Connection Failed');

      throw Exception(e);
    }

 
  } Future<void> flyTo(String location) async {
    await ssh.execute('echo "flytoview=$location" > /tmp/query.txt');
  }



  
 
  Future<void> clearSlave(String screen) async {
    final kml = SendKML.sendClean('slave_$screen');

    try {
      await ssh.connectToserver();
      await ssh.execute("echo '$kml' > /var/www/html/kml/slave_$screen.kml");
      showToast('Clear Logo');
    } catch (e) {
      // ignore: avoid_print
      print(e);
      showToast('Something went wrong $e');
    }
  }

  Future<void> clearKml() async {
    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
    try {
      await ssh.connectToserver();
      showToast('Clear KML');
      await ssh.execute(query);
    } catch (e) {
      showToast('Something went wrong');

      throw Exception(e);
    }
  }

  Future<void> connect() async {
    try {
      await ssh.connectToserver();
      showToast('Connected');
      _established = true;
    } catch (e) {
      showToast('Connection Failed');
      _established = false;

      throw Exception(e);
    }
  }

  Future<void> disconnect() async {
    ssh.disconnect();
    _established = false;
    showToast('Disconnected');
  }
}
