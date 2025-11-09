import 'package:flutter/cupertino.dart';
import 'package:mydj/Data/Jurnal.dart';

class DataProvider extends ChangeNotifier {
  List<Jurnal> _JurnalTersimpan = [];
  DataProvider();

  void tambahJurnal(Jurnal jurnal) {
    this._JurnalTersimpan.add(jurnal);
    notifyListeners();
  }

  List<Jurnal> get jurnalTersimpan {
    return List.unmodifiable(_JurnalTersimpan);
  }
}
