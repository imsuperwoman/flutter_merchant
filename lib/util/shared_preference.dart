import 'package:mse_customer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class UserPreferences {
//   Future<bool> saveUser(User user) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    // prefs.setInt('userId', user.userId);
//     prefs.setString('name', user.name);
//     prefs.setString('email', user.email);
//     prefs.setString('mobilePhone', user.mobilePhone);
//    // prefs.setString('type', user?.type);
//    // prefs.setString('token', user.token);
//
//     return true;
//   }
//
//   Future<User> getUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     int? userId = prefs.getInt("userId");
//     String? name = prefs.getString("name");
//     String? email = prefs.getString("email");
//     String? mobilePhone = prefs.getString("mobilePhone");
//     String? type = prefs.getString("type");
//     String? token = prefs.getString("token");
//     String? renewalToken = prefs.getString("renewalToken");
//
//     return User(
//         userId: userId,
//         name: "name",
//         email: "email",
//         mobilePhone: "mobilePhone",
//         type: type,
//         token: token,
//         renewalToken: renewalToken, identity: '');
//   }
//
//   void removeUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     prefs.remove('userId');
//     prefs.remove('name');
//     prefs.remove('email');
//     prefs.remove('mobilePhone');
//     prefs.remove('type');
//     prefs.remove('token');
//   }
//
//   Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//      String? token = prefs.getString("token");
//     return token;
//   }
// }

class PrefService {
  Future createCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("password", password);
  }

  Future readCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");
    return cache;
  }

  Future removeCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }
}
