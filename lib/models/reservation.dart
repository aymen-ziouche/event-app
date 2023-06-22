import 'package:cloud_firestore/cloud_firestore.dart';


class Reservation {
  final String clientId;
  final String reservationId;
  final String salleName;
  final String salleLocation;
  final String date;
  final String startTime;
  final String endTime;

  Reservation({
    this.clientId = '',
    this.reservationId = '',
    this.salleName = '',
    this.salleLocation = '',
    this.date = '',
    this.startTime = '',
    this.endTime = '',
  });
  
    factory Reservation.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Reservation(
      clientId: data['clientId'] ?? '',
      reservationId: data['reservationId'] ?? '',
      salleName: data['salleName'] ?? '',
      salleLocation: data['salleLocation'] ?? '',
      date: data['date'] ?? '',
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
    );
  }
}