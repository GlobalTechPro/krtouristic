import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';
import 'package:krtouristic/model/core/location.dart';

class LocationApi {
  static Future<Either<Object, Location>> getLocation(
      {required String locationId}) async {
    try {
      final locationDocRef = getIt<FirebaseFirestore>()
          .collection("Location")
          .doc(locationId)
          .withConverter(
            fromFirestore: Location.fromFirestore,
            toFirestore: (Location location, _) => location.toFirestore(),
          );
      final locationDocSnap = await locationDocRef.get();
      final location = locationDocSnap.data();
      if (location != null) {
        return Right(location);
      } else {
        return Left(Exception('Document unavailable'));
      }
    } catch (e) {
      return Left(e);
    }
  }

  static Future<Either<Object, List>> getLocations({
    required int cityId,
    required String lang,
    String? searchStr,
    String? locationTypeName,
    String? sightGroupName,
    bool? top,
  }) async {
    var locations = [];
    try {
      final locationDocsRef = getIt<FirebaseFirestore>()
          .collection("Location")
          .where("city_id", isEqualTo: cityId)
          .where("lang", isEqualTo: lang);
      final locationSnap = await locationDocsRef.get();

      if (searchStr != null) {
        locations = locationSnap.docs
            .where((item) => item['title']
                .toString()
                .toLowerCase()
                .contains(searchStr.toLowerCase()))
            .toList();
        return Right(locations);
      }
      if (locationTypeName != null) {
        locations = locationSnap.docs.where((item) {
          if (item.data().containsKey('location_type')) {
            return item['location_type']['name'] == locationTypeName;
          } else {
            return false;
          }
        }).toList();
        return Right(locations);
      }
      if (sightGroupName != null) {
        locations = locationSnap.docs.where((item) {
          if (item.data().containsKey('sight_group')) {
            return item['sight_group']['name'] == sightGroupName;
          } else {
            return false;
          }
        }).toList();
        return Right(locations);
      }
      if (top != null) {
        locations = locationSnap.docs.where((item) {
          if (item.data().containsKey('top')) {
            return item['top'] == top;
          } else {
            return false;
          }
        }).toList();
        return Right(locations);
      }
      locations = locationSnap.docs;
      return Right(locations);
    } catch (e) {
      return Left(e);
    }
  }

  // @TODO implement getNearestLocations
}
