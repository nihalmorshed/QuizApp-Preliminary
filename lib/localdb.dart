import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static final uidKey = "fsfjkfskjfsfv";
  static final lkey = "467435bvesgwyh";
  static final rkey = "4543467435bvesgwyh";
  static final nkey = "45363w54svegrft";
  static final skey = "65g14er4efesdfeaswcsdfv45";

  static Future<bool> saveUserID(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(uidKey);
  }

  static Future<bool> saveMoney(String score) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(skey, score);
  }

  static Future<String?> getMoney() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(skey);
  }

  static Future<bool> saveName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nkey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nkey);
  }

  static Future<bool> saveLevel(String level) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lkey, level);
  }

  static Future<String?> getLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(lkey);
  }

  static Future<bool> saveRank(String rank) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(rkey, rank);
  }

  static Future<String?> getRank() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(rkey);
  }
}
