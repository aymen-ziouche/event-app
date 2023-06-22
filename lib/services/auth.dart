import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(
      String email, String password, String name, String address) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = authResult.user;
      final permission = await Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final latitude = position.latitude;
      final longitude = position.longitude;

      // Save the user's information on Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'name': name,
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      });

      return authResult;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          throw 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          throw 'The email address is already registered.';
        } else if (e.code == 'invalid-email') {
          throw 'The email address is not valid.';
        } else {
          throw 'Registration failed. Please try again later.';
        }
      } else {
        throw 'Registration failed. Please try again later.';
      }
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult;
    } catch (e) {
      throw 'Login failed. Please check your email and password.';
    }
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> logout() async => await _auth.signOut();
}
