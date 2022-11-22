import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';
import 'package:krtouristic/model/core/guided_tour.dart';

class GuidedTourApi {
  static Future<Either<Object, GuidedTour>> getTourById(
      {required String tourId}) async {
    try {
      final tourDocRef = getIt<FirebaseFirestore>()
          .collection("GuidedTour")
          .doc(tourId)
          .withConverter(
            fromFirestore: GuidedTour.fromFirestore,
            toFirestore: (GuidedTour guidedTour, _) => guidedTour.toFirestore(),
          );
      final tourDocSnap = await tourDocRef.get();
      final tour = tourDocSnap.data();
      if (tour != null) {
        return Right(tour);
      } else {
        return Left(Exception('Document unavailable'));
      }
    } catch (e) {
      return Left(e);
    }
  }

  static Future<Either<Object, List>> getGuidedTours({
    required int cityId,
    required String lang,
    String? searchStr,
    String? guideName,
    String? guidedTourTypeName,
    bool? top,
  }) async {
    // @TODO implement search with the searchStr, guideName, guidedTourTypeName, top
    try {
      var guidedTours = [];
      final guidedTourDocRef = getIt<FirebaseFirestore>()
          .collection("GuidedTour")
          .where("city_id", isEqualTo: cityId)
          .where("lang", isEqualTo: lang);
      final guidedTourSnap = await guidedTourDocRef.get();

      if (searchStr != null) {
        guidedTours = guidedTourSnap.docs
            .where((item) => item['title']
                .toString()
                .toLowerCase()
                .contains(searchStr.toLowerCase()))
            .toList();
        return Right(guidedTours);
      }
      if (guideName != null) {
        guidedTours = guidedTourSnap.docs.where((item) {
          if (item.data().containsKey('guide')) {
            if (item['guide']['name']['first']
                    .toString()
                    .toLowerCase()
                    .contains(guideName.toLowerCase()) ||
                item['guide']['name']['last']
                    .toString()
                    .toLowerCase()
                    .contains(guideName.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        }).toList();
        return Right(guidedTours);
      }
      if (guidedTourTypeName != null) {
        guidedTours = guidedTourSnap.docs.where((item) {
          if (item.data().containsKey('guided_tour_type')) {
            return item['guided_tour_type']['name'] == guidedTourTypeName;
          } else {
            return false;
          }
        }).toList();
        return Right(guidedTours);
      }
      if (top != null) {
        guidedTours = guidedTourSnap.docs.where((item) {
          if (item.data().containsKey('top')) {
            return item['top'] == top;
          } else {
            return false;
          }
        }).toList();
        return Right(guidedTours);
      }

      guidedTours = guidedTourSnap.docs;
      return Right(guidedTours);
    } catch (e) {
      return Left(e);
    }
  }
}
