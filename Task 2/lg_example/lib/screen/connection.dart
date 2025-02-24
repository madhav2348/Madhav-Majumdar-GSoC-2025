import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lg_example/service/lg_connection.dart';
import 'package:lg_example/service/shared_pref.dart';
import 'package:lg_example/service/ssh_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key, required this.connection});

  final void Function(bool) connection;

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool isConnected = false;

  LGConnection _lg = LGConnection();
  SSHService ssh = SSHService();

  TextEditingController _user = TextEditingController(text: 'lg');
  TextEditingController _pass = TextEditingController(text: 'lg');
  TextEditingController _ip = TextEditingController();
  TextEditingController _port = TextEditingController(text: '22');

  Future<List<String?>> _getPersistence() async {
    SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // allowList: <String>{'repeat', 'action'},
      ),
    );

    final p_Ip = prefs.getString('master_ip');
    final p_pass = prefs.getString('master_password');
    final p_port = prefs.getString('master_portNumber');
    final p_user = prefs.getString('master_username');
    

    _user.text = p_user!;
    _pass.text = p_pass!;
    _ip.text = p_Ip!;
    _port.text = p_port!;
    return [p_Ip, p_pass, p_port, p_user];
  }

  onSubmit(String user, String pass, String ip, String port) async {
    // Navigator.pop(context);
    try {
      await SharedPref.setData(user, pass, ip, port, true);


      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pop();
          });
          return SizedBox(
            width: 100,
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        },
      );
      await _lg.connect();


      widget.connection(_lg.establish);
      Navigator.pop(context);

    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getPersistence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 150, 40, 20),
            child: Form(
              child: Column(
                spacing: 30,
                children: [
                  Text(
                    'Set Connection',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(width: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),

                      label: Text('Username'),
                    ),
                    controller: _user,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),

                      label: Text('Password'),
                      prefixIcon: Icon(Icons.key_outlined),
                    ),
                    controller: _pass,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),

                      label: Text('IP Address'),
                      prefixIcon: Icon(Icons.router_outlined),
                    ),
                    controller: _ip,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),

                      label: Text('Port'),
                      prefixIcon: Icon(Icons.computer_outlined),
                    ),
                    controller: _port,
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          states,
                        ) {
                          return BorderSide(
                            // width: 2,
                            color: Colors.white,
                          );
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.white;
                          },
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.greenAccent.shade700;
                          },
                        ),
                      ),
                      onPressed: () {
                        onSubmit(_user.text, _pass.text, _ip.text, _port.text);
                        setState(() {
                          isConnected = !isConnected;
                        });
                      },
                      label: Text('Connect', style: TextStyle(fontSize: 20)),
                      icon: Icon(
                        Icons.cable_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
