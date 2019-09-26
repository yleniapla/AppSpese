import 'package:flutter/foundation.dart';

class Transazione {
  String id;
  String titolo;
  double importo;
  DateTime data;

  Transazione({
    @required this.id,
    @required this.titolo,
    @required this.importo,
    @required this.data,
  });
}
