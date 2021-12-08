import 'package:flutter/material.dart';

/// The [QRCodes] class holds a list of QRCode items scanned by the user.
class QRCodes extends ChangeNotifier {
  final List<String?> _qrcodeItems = [];

  List<String?> get items => _qrcodeItems;

  void add(String? itemNo) {
    _qrcodeItems.add(itemNo);
    notifyListeners();
  }

  void remove(String itemNo) {
    _qrcodeItems.remove(itemNo);
    notifyListeners();
  }
}