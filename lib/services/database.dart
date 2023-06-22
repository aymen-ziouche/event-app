import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/reservation.dart';
import 'package:event_app/models/salles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  Future<List<Salles>> loadSalles() async {
    try {
      final sallesSnapshot =
          await FirebaseFirestore.instance.collection('partners').get();
      return sallesSnapshot.docs
          .map((doc) => Salles(
                name: doc.get('name'),
                type: doc.get('type'),
                capacity: doc.get('capacity'),
                location: doc.get('location'),
                rating: doc.get('rating'),
                uid: doc.get('uid'),
                photoUrl: doc.get('photoUrl'),
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String docId = FirebaseFirestore.instance.collection("reservations").doc().id;
  Future<void> addReservation({
    required String date,
    required String salleName,
    required String salleLocation,
    required String startTime,
    required String endTime,
  }) async {
    final user = _auth.currentUser;

    await FirebaseFirestore.instance.collection('reservations').doc().set({
      'clientId': user?.uid,
      'reservationId': docId,
      'salleName': salleName,
      'salleLocation': salleLocation,
      'date': date,
      'startTime': startTime,
      'endTime': endTime
    });
  }

  Future<List<Reservation>> loadreservations() async {
    final user = _auth.currentUser;

    try {
      final reservationsSnapshot = await FirebaseFirestore.instance
          .collection('reservations')
          .where("clientId", isEqualTo: user?.uid)
          .get();
      return reservationsSnapshot.docs
          .map((doc) => Reservation(
                clientId: doc.get("clientId"),
                reservationId: doc.get("reservationId"),
                salleName: doc.get("salleName"),
                date: doc.get("date"),
                salleLocation: doc.get("salleLocation"),
                startTime: doc.get("startTime"),
                endTime: doc.get("endTime"),
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
