import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setNotFirstTime() async {
    bool isSuccess = await _prefs.setBool("isFirstTime", false);
    print(isSuccess ? "success" : "failed");
  }

  static String get name {
    return _prefs.getString("name") ?? "";
  }

  static String get token {
    return _prefs.getString("token") ??
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9hcGlcL2xvZ2luIiwiaWF0IjoxNzQxMjIwMjQxLCJleHAiOjE3NzI3NTYyNDEsIm5iZiI6MTc0MTIyMDI0MSwianRpIjoiVVhkR0pTalpaUE5IUVRLTCIsInN1YiI6MTQ4OSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.T-q6en2UKVyzU5XKLecbdkPCxiAuG3Lvc22jvGh_pYY";
  }

  static int get age {
    return _prefs.getInt("age") ?? 0;
  }

  static bool get isFirstTime {
    return _prefs.getBool("isFirstTime") ?? true;
  }
}
