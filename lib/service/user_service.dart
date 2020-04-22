import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection_ext/iterables.dart';
import 'package:flutter/material.dart';

import 'package:flt_keep/models.dart' show Note, NoteState;
import 'package:flt_keep/styles.dart';

class UserRole extends ChangeNotifier {
  final String id;
  String name;
  String role;
  DateTime createdAt;
  DateTime modifiedAt;

  /// Instantiates a [UserRole]
  UserRole(
    this.id,
    this.name,
    this.role,
    DateTime createdAt,
    DateTime modifiedAt,
  )   : this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  /// Serializes this note into a JSON object.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'createdAt': (createdAt ?? DateTime.now()).millisecondsSinceEpoch,
        'modifiedAt': (modifiedAt ?? DateTime.now()).millisecondsSinceEpoch,
      };
}

extension UserRoleStore on UserRole {
  Future<dynamic> saveToFireStore() async {
    final col = usersCollection(id);
    return id == null ? col.add(toJson()) : col.document(id).setData(toJson());
  }

  /// Returns reference to the notes collection of the user [uid].
  CollectionReference usersCollection(String uid) =>
      Firestore.instance.collection('user-$uid');
}
