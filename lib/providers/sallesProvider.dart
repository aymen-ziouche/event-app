import 'package:event_app/models/salles.dart';
import 'package:event_app/services/database.dart';
import 'package:flutter/material.dart';

class SallesProvider extends ChangeNotifier {
  List<Salles> _salles = [];

  List<Salles> get salles => _salles;

  set salles(List<Salles> value) {
    _salles = value;
    notifyListeners();
  }

  Future<void> fetchsalles() async {
    final firebaseService = Database();
    salles = await firebaseService.loadSalles();
  }
}
