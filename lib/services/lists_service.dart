import 'package:final_flutter/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListsService {
  final dbReference = Firestore.instance;
  final auth = FirebaseAuth.instance;

  List<SelectedProduct> userList;

  ListsService() {
    userList = List<SelectedProduct>();
  }
}
