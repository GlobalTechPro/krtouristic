import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class GuidedTourType {
  GuidedTourType({
    required this.title,
    required this.name,
  });

  final String title;
  final String name;

  factory GuidedTourType.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
    } else {
      data = snapshot;
    }
    return GuidedTourType(
      title: data?['title'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "lang": globals.lang,
      "title": title,
      "name": name,
    };
  }
}
