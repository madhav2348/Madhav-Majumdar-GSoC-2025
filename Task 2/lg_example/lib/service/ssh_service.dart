import 'package:dartssh2/dartssh2.dart';
import 'package:lg_example/service/shared_pref.dart';

class SSHService {
  static final SSHService _instance = SSHService._internal();

  int? _port;
  String? _ip;
  String? _password;
  String? _user;
  SSHClient? _client;
  SSHSocket? _socket;

  Future<Set?> get _init async {
    // final _pref = ();
    final data = await SharedPref.getData();

    _user = data['user']!;
    _password = data['pass']!;
    _ip = data['ip']!;
    _port = int.parse(data['port']!);
    // print({_password, _port, _ip, _user});
    return {_port, _ip, _password, _user};
  }

  factory SSHService() {
    return _instance;
  }
  SSHService._internal();
 Future<SSHClient?> connectToserver() async {
    try {
      await _init;

      _socket = await SSHSocket.connect(_ip!, _port!);
      _client = SSHClient(
        _socket!,
        username: _user!,
        onPasswordRequest: () => _password,
      );
    } catch (e) {
      throw Exception(e);
    }
    return  _client;
  }

  Future<SSHSession> execute(String command) async {
    if (_client == null) await connectToserver();
    return  _client!.execute(command);
  }

  void disconnect() async{
    _client!.close();
    _client = null;
  }
}
