import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class Guide {
  Guide({
    required this.name,
    required this.phone,
    this.subtitle,
    this.description,
    this.email,
    this.spokenLanguages,
    this.avatar,
    this.youtubeUrl,
  });

  final dynamic name;
  final String phone;
  final String? subtitle;
  final String? description;
  final String? email;
  final List<dynamic>? spokenLanguages;
  final NetworkImage? avatar;
  final String? youtubeUrl;

  factory Guide.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
    } else {
      data = snapshot;
    }
    return Guide(
      name: data?['name'],
      phone: data?['phone'],
      subtitle: data?['subtitle'],
      description: data?['description'],
      email: data?['email'],
      spokenLanguages: data?['spoken_languages'],
      avatar: data?['avatar'] != null ? NetworkImage(data?['avatar']) : null,
      youtubeUrl: data?['youtube_url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "city_id": globals.cityId,
      "lang": globals.lang,
      "name": name,
      "phone": phone,
      if (subtitle != null) "subtitle": subtitle,
      if (description != null) "description": description,
      if (email != null) "email": email,
      if (spokenLanguages != null) "spoken_languages": spokenLanguages,
      if (avatar != null) "avatar": avatar!.url,
      if (youtubeUrl != null) "youtube_url": youtubeUrl,
    };
  }
}
