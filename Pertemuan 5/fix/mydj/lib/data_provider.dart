import 'package:flutter/cupertino.dart';
import 'package:mydj/Data/Jurnal.dart';
import 'package:mydj/Data/login_info.dart';

class DataProvider extends ChangeNotifier {
  final List<Jurnal> _JurnalTersimpan = [];
  DataProvider();

  void tambahJurnal(Jurnal jurnal) {
    _JurnalTersimpan.add(jurnal);
    notifyListeners();
  }

  List<Jurnal> get jurnalTersimpan {
    return List.unmodifiable(_JurnalTersimpan);
  }

  Future<bool> isLoggedIn() async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    return loginInfo.isLoggedIn;
  }

  Future<void> saveLoginInfo(String username, String password) async {
    LoginInfo loginInfo = await LoginInfo.fromSharedPreferences();
    loginInfo.username = username;
    loginInfo.password = password;
    loginInfo.isLoggedIn = true;
    loginInfo.saveToSharedPreferences();
  }
}
