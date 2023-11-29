import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

class UserData {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getDataFromFirestore(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _collectionReference.doc(documentId).get();

      if (documentSnapshot.exists) {
        // Document found, return its data
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        // Document not found
        print('Document does not exist');
        return {};
      }
    } catch (e) {
      print('Error fetching document: $e');
      return {};
    }
  }
}
