import 'package:flutter/cupertino.dart';
import 'package:mse_customer/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = new User(email: '', name: '', type:'', contactNumber :'');

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

}
