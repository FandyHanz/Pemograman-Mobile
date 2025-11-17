import 'package:flutter/cupertino.dart';
import 'package:mydj/Data/Jurnal.dart';

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
}
