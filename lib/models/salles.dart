import 'package:cloud_firestore/cloud_firestore.dart';

class Salles {
  final String uid;
  final String name;
  final String location;
  final String capacity;
  final String rating;
  final String type;
  final String photoUrl;

  Salles({
    this.uid = '',
    this.name = '',
    this.location = '',
    this.capacity = '',
    this.rating = '',
    this.type = '',
    this.photoUrl = '',
  });

  factory Salles.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Salles(
        uid: snapshot.id,
        name: data['name'] ?? '',
        location: data['location'] ?? '',
        capacity: data['capacity'] ?? '',
        rating: data['rating'] ?? '',
        type: data['type'] ?? '',
        photoUrl: data['photoUrl'] ?? '');
  }
}
