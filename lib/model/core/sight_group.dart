import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class SightGroup {
  SightGroup({
    required this.name,
    required this.title,
    this.subtitle,
    this.icon,
  });

  final String name;
  final String title;
  final String? subtitle;
  final AssetImage? icon;

  factory SightGroup.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
    } else {
      data = snapshot;
    }
    return SightGroup(
      name: data?['name'],
      title: data?['title'],
      subtitle: data?['subtitle'],
      icon: data?['icon'] is String ? AssetImage(data?['icon']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "lang": globals.lang,
      "name": name,
      "title": title,
      if (subtitle != null) "subtitle": subtitle,
    };
  }
}
