import 'package:event_app/models/reservation.dart';
import 'package:event_app/services/database.dart';
import 'package:flutter/material.dart';

class ReservationsProvider extends ChangeNotifier {
  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  set reservations(List<Reservation> value) {
    _reservations = value;
    notifyListeners();
  }

  Future<void> fetchReservations() async {
    final firebaseService = Database();
    reservations = await firebaseService.loadreservations();
  }
}
