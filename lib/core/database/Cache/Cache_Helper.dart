
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
   late SharedPreferences sharedPreferences;

   init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

  //put data in local database
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  //get data already saved in database
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }
}
