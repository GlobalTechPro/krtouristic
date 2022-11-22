import 'package:krtouristic/model/core/guide.dart';
import 'package:krtouristic/model/core/guided_tour_type.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/core/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class GuidedTour {
  GuidedTour({
    required this.guidedTourType,
    required this.title,
    required this.locations,
    required this.headImage,
    required this.length,
    this.subtitle,
    this.description,
    this.pricing,
    this.top,
    this.galleryImages,
    this.guide,
    this.schedule,
    this.youtubeUrl,
    this.firebaseId,
  });

  final GuidedTourType guidedTourType;
  final String title;
  final List<Location> locations;
  final NetworkImage headImage;
  final int length;
  final String? description;
  final String? subtitle;
  final String? pricing;
  final bool? top;
  final List<String>? galleryImages;
  final Guide? guide;
  final List<Schedule>? schedule;
  final String? youtubeUrl;
  final String? firebaseId;

  factory GuidedTour.fromFirestore(
    dynamic snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data;
    if (snapshot is DocumentSnapshot<Map<String, dynamic>>) {
      data = snapshot.data();
    } else {
      data = snapshot;
    }
    String firebId = snapshot.id;
    List<dynamic> locationsData = [];
    List<dynamic> scheduleData = [];
    List<Schedule> schedule = [];
    List<Location> tourLocations = [];
    if (data?['locations'] != null) {
      locationsData = data?['locations'];
      locationsData
          .map((locationItem) =>
              {tourLocations.add(Location.fromFirestore(locationItem, null))})
          .toList();
    }
    if (data?['schedule'] != null) {
      scheduleData = data?['schedule'];
      scheduleData.map((scheduleItem) {
        schedule.add(Schedule.fromFirestore(scheduleItem, null));
      }).toList();
    }
    return GuidedTour(
      guidedTourType:
          GuidedTourType.fromFirestore(data?['guided_tour_type'], null),
      title: data?['title'],
      locations: tourLocations,
      headImage: NetworkImage(data?['head_image']),
      length: data?['length'] ?? 0,
      subtitle: data?['subtitle'],
      description: data?['description'],
      pricing: data?['pricing'],
      top: data?['top'],
      galleryImages: data?['gallery_images'] is Iterable
          ? List.from(data?['gallery_images'])
          : null,
      guide: data?['guide'] != null
          ? Guide.fromFirestore(data!['guide'], null)
          : null,
      schedule: schedule.isNotEmpty ? schedule : null,
      youtubeUrl: data?['youtube_url'],
      firebaseId: firebId,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "city_id": globals.cityId,
      "lang": globals.lang,
      "guided_tour_type": guidedTourType.toFirestore(),
      "title": title,
      "locations": locations.map((locationItem) {
        locationItem.toFirestore();
      }).toList(),
      "head_image": headImage.url,
      "length": length,
      if (subtitle != null) "subtitle": subtitle,
      if (description != null) "description": description,
      if (pricing != null) "pricing": pricing,
      if (top != null) "top": top,
      if (youtubeUrl != null) "youtube_url": youtubeUrl,
      if (galleryImages!.isNotEmpty) "gallery_images": galleryImages,
      if (guide != null) "guide": guide!.toFirestore(),
      if (schedule != null)
        "schedule": schedule?.map((scheduleItem) {
          scheduleItem.toFirestore();
        }).toList(),
    };
  }
}
