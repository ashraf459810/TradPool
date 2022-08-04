import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/core/consts.dart';

abstract class VerficationLocatData {
  Future<void> setUserverfiy(bool isbool);
  Future<bool> getIfUserverfiy();
  Future<void> saveToken(String token);
  Future<String> getToken();
}

class VerficationLocalDataImpl implements VerficationLocatData {
  final SharedPreferences sharedPreferences;

  VerficationLocalDataImpl(this.sharedPreferences);

  @override
  Future<bool> getIfUserverfiy() async {
    return (sharedPreferences.getBool(Con.isverify) ?? false);
  }

  @override
  Future<void> setUserverfiy(bool isbool) async {
    await sharedPreferences.setBool(Con.isverify, isbool);
  }

  @override
  Future<String> getToken() async {
    return (sharedPreferences.getString(Con.token));
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(Con.token, token);
  }
}
