import 'package:krtouristic/model/core/location_type.dart';
import 'package:krtouristic/model/core/schedule.dart';
import 'package:krtouristic/model/core/sight_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class Location {
  Location({
    required this.lat,
    required this.lng,
    required this.title,
    this.headImage,
    this.subtitle,
    this.description,
    this.locationType,
    this.sightGroup,
    this.address,
    this.phone,
    this.email,
    this.pricing,
    this.schedule,
    this.top,
    this.youtubeUrl,
    this.galleryImages,
    this.firebaseId,
  });

  final double lat;
  final double lng;
  final String title;
  final String? subtitle;
  final String? description;
  final LocationType? locationType;
  final SightGroup? sightGroup;
  final String? address;
  final String? phone;
  final String? email;
  final String? pricing;
  final List<Schedule>? schedule;
  final bool? top;
  final String? youtubeUrl;
  final dynamic headImage;
  final List<String>? galleryImages;
  final String? firebaseId;

  factory Location.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    String firebId = '';
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
      firebId = snapshot.id;
    } else {
      data = snapshot;
    }
    List<dynamic> scheduleData = [];
    if (data?['schedule'] != null) {
      scheduleData = data?['schedule'];
    }
    List<Schedule> schedule = [];
    if (scheduleData.isNotEmpty) {
      scheduleData.map((scheduleItem) {
        schedule.add(Schedule.fromFirestore(scheduleItem, null));
      }).toList();
    }
    return Location(
      lat: data?['lat'],
      lng: data?['lng'],
      title: data?['title'],
      headImage: data?['head_image'] != null
          ? NetworkImage(data?['head_image'])
          : const AssetImage('assets/img_placeholder.png'),
      subtitle: data?['subtitle'],
      description: data?['description'],
      locationType: data?['location_type'] != null
          ? LocationType.fromFirestore(data?['location_type'], null)
          : null,
      sightGroup: data?['sight_group'] != null
          ? SightGroup.fromFirestore(data?['sight_group'], null)
          : null,
      address: data?['address'],
      phone: data?['phone'],
      email: data?['email'],
      pricing: data?['pricing'],
      schedule: schedule.isNotEmpty ? schedule : null,
      top: data?['top'],
      youtubeUrl: data?['youtube_url'],
      galleryImages: data?['gallery_images'] is Iterable
          ? List.from(data?['gallery_images'])
          : null,
      firebaseId: firebId,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "city_id": globals.cityId,
      "lang": globals.lang,
      "lat": lat,
      "lng": lng,
      "title": title,
      if (headImage is NetworkImage) "head_image": headImage.url,
      if (subtitle != null) "subtitle": subtitle,
      if (description != null) "description": description,
      if (locationType != null) "location_type": locationType?.toFirestore(),
      if (sightGroup != null) "sight_group": sightGroup?.toFirestore(),
      if (address != null) "address": address,
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
      if (pricing != null) "pricing": pricing,
      if (youtubeUrl != null) "youtube_url": youtubeUrl,
      if (schedule != null)
        "schedule": schedule?.map((scheduleItem) {
          scheduleItem.toFirestore();
        }).toList(),
      if (top != null) "top": top,
      if (galleryImages != null) "gallery_images": galleryImages,
    };
  }
}
