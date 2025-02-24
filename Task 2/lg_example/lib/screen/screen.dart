import 'package:flutter/material.dart';
import 'package:lg_example/model/dummy.dart';
import 'package:lg_example/model/kml.dart';
import 'package:lg_example/screen/connection.dart';
import 'package:lg_example/service/lg_connection.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  LGConnection _lg = LGConnection();

  Future connection() async {
    await _lg.connect();
    if (_lg.establish) {
      setState(() {
        isConnected = true;
      });
    }
  }

  void restore() {
    isAdded.fillRange(0, isAdded.length, false);
  }

  void sendKML(KML kml, String location, int listId) async {
    try {
      await _lg.sendKml(kml);
      await _lg.flyTo(location);
      setState(() {
        isAdded[listId] = true;
      });
    } catch (e) {
      setState(() {
        isAdded[listId] = true;
      });
      throw Exception(e);
    }
  }

  void sendLogo() async {
    try {
      await _lg.sendToLG();
      setState(() {
        isAdded[0] = true;
      });
    } catch (e) {
      setState(() {
        isAdded[0] = false;
      });

      throw Exception(e);
    }
  }

  void clearLogo() async {
    try {
      await _lg.clearSlave('3');
      setState(() {
        isAdded[0] = false;
      });
    } catch (e) {
      setState(() {
        isAdded[0] = true;
      });

      throw Exception(e);
    }
  }

  void clearKML() async {
    try {
      await _lg.clearKml();
      setState(() {
        setState(() {
          restore();
        });
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  bool isConnected = false;
  // List<bool> isRemove = [false, false];
  List<bool> isAdded = [false, false, false];
  List<bool> get restoreDefault => [...isAdded];
  @override
  void initState() {
    super.initState();
    connection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            spacing: 60,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 176,
                height: 72,
                child: ElevatedButton.icon(
                  icon: Icon(
                    isConnected ? Icons.wifi : Icons.wifi_off,
                    size: 25,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
                      return BorderSide(
                        // width: 2,
                        color: Colors.white,
                      );
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return Colors.white;
                    }),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return isConnected
                          ? Colors.greenAccent.shade700
                          : Colors.yellowAccent.shade700;
                    }),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => ConnectionPage(
                              connection: (value) {
                                setState(() {
                                  isConnected = value;
                                });
                              },
                            ),
                      ),
                    );
                    setState(() {});
                  },
                  label: Text(
                    isConnected ? 'Connected' : 'Disconnect',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: 176,
                height: 72,
                child: OutlinedButton.icon(
                  icon: Icon(
                    Icons.add_box_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
                      return BorderSide(
                        color:
                            isAdded[0]
                                ? Colors.greenAccent.shade700
                                : Colors.blueAccent,
                        width: 2,
                      );
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return Colors.white;
                    }),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      return isAdded[0]
                          ? Colors.greenAccent.shade700
                          : Colors.blueAccent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      sendLogo();
                      //  = !isAdded[0];
                    });
                  },
                  label: Text('Add Logo', style: TextStyle(fontSize: 18)),
                ),
              ),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 176,
                    height: 72,
                    child: OutlinedButton.icon(
                      icon: ImageIcon(
                        AssetImage('assets/image/GE_logo.png'),
                        size: 20,
                        color: Colors.white,
                      ),

                      style: ButtonStyle(
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          states,
                        ) {
                          return BorderSide(
                            color:
                                isAdded[1]
                                    ? Colors.greenAccent.shade700
                                    : Colors.blueAccent,
                            width: 2,
                          );
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.white;
                          },
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return isAdded[1]
                                ? Colors.greenAccent.shade700
                                : Colors.blueAccent;
                          },
                        ),
                      ),
                      onPressed: () {
                        sendKML(
                          KML('SEND_KML_1', content: kml1, id: '111'),
                          kml1location,
                          1,
                        );
                      },
                      label: Text('Send KML 1', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  SizedBox(
                    width: 176,
                    height: 72,
                    child: OutlinedButton.icon(
                      icon: ImageIcon(
                        AssetImage('assets/image/GE_logo.png'),
                        size: 20,
                        color: Colors.white,
                      ),

                      style: ButtonStyle(
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          states,
                        ) {
                          return BorderSide(
                            color:
                                isAdded[2]
                                    ? Colors.greenAccent.shade700
                                    : Colors.blueAccent,
                            width: 2,
                          );
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.white;
                          },
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return isAdded[2]
                                ? Colors.greenAccent.shade700
                                : Colors.blueAccent;
                          },
                        ),
                      ),
                      onPressed: () {
                        sendKML(
                          KML('SEND_KML_2', content: kml2, id: '222'),
                          kml2location,
                          2,
                        );
                      },
                      label: Text('Send KML 2', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 176,
                    height: 72,
                    child: OutlinedButton.icon(
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          states,
                        ) {
                          return BorderSide(color: Colors.red, width: 2);
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.white;
                          },
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.red;
                          },
                        ),
                      ),
                      onPressed: () {
                        clearLogo();
                        setState(() {
                          // isRemove[0] = !isRemove[0];
                        });
                      },
                      label: Text('Clear Logo', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                  SizedBox(
                    width: 176,
                    height: 72,
                    child: OutlinedButton.icon(
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 25,
                        color: Colors.white,
                      ),

                      style: ButtonStyle(
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          states,
                        ) {
                          return BorderSide(color: Colors.red, width: 2);
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.white;
                          },
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            return Colors.red;
                          },
                        ),
                      ),
                      onPressed: () {
                        clearKML();
                      },
                      label: Text('Clear KML', style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   width: 176,
              //   height: 72,
              //   child: ElevatedButton.icon(
              //     icon: Icon(
              //       Icons.restore_outlined,
              //       size: 25,
              //       color:
              //          Colors.white
              //     ),

              //     style: ButtonStyle(
              //       side: WidgetStateProperty.resolveWith<BorderSide>((states) {
              //         return BorderSide(
              //           color:
              //               restoreDefault.contains(true)
              //                   ? Colors.yellowAccent.shade700
              //                   : Colors.greenAccent.shade700,
              //           width: 2,
              //         );
              //       }),
              //       foregroundColor: WidgetStateProperty.resolveWith<Color>((
              //         states,
              //       ) {
              //         return Colors.white;
              //       }),
              //       backgroundColor: WidgetStateProperty.resolveWith<Color>((
              //         states,
              //       ) {
              //         return restoreDefault.contains(true)
              //             ? Colors.yellowAccent.shade700
              //             : Colors.greenAccent.shade700;
              //       }),
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         restore(false);
              //       });
              //     },
              //     label: Text('Restore', style: TextStyle(fontSize: 17)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
