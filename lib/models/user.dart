import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String latitude;
  final String longitude;
  late String city;
  late String country;

  User({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.address = '',
    this.latitude = '',
    this.longitude = '',
    this.city = '',
    this.country = '',
  });

  factory User.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return User(
      uid: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      latitude: data['latitude'].toString(),
      longitude: data['longitude'].toString(),
    );
  }
}
