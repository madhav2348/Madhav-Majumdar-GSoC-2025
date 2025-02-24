import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._internal();

  factory SharedPref() {
    return instance;
  }
  SharedPref._internal();
  static Future<Map<String, dynamic>> getData() async {
    SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // allowList: <String>{'repeat', 'action'},
      ),
    );

    final p_Ip = prefs.getString('master_ip');
    final p_pass = prefs.getString('master_password');
    final p_port = prefs.getString('master_portNumber');
    final p_user = prefs.getString('master_username');
    final p_est = prefs.getBool('established');

    return {"ip": p_Ip!, "pass": p_pass!, "port": p_port!, "user": p_user! ,"est":p_est!};
  }

  static Future<void> setData(
    String user,
    String pass,
    String ip,
    String port,
    bool est
  ) async {
   
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            // allowList: <String>{'repeat', 'action'},
          ),
        );

    await prefsWithCache.setString('master_ip', ip);
    await prefsWithCache.setString('master_password', pass);
    await prefsWithCache.setString('master_portNumber', port);
    await prefsWithCache.setString('master_username', user);
    await prefsWithCache.setBool('established', est);
  }
}
