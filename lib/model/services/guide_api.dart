import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';

class GuideApi {
  static Future<Either<Object, List>> getGuides(
      {required int cityId, required String lang, String? searchStr}) async {
    var guides = [];
    try {
      final guideDocRef = getIt<FirebaseFirestore>()
          .collection("Guide")
          .where("city_id", isEqualTo: cityId)
          .where("lang", isEqualTo: lang);
      final guideSnap = await guideDocRef.get();
      if (searchStr != null) {
        guideSnap.docs.map((guide) {
          if (guide['name']['first']
                  .toString()
                  .toLowerCase()
                  .contains(searchStr.toLowerCase()) ||
              guide['name']['last']
                  .toString()
                  .toLowerCase()
                  .contains(searchStr.toLowerCase())) {
            guides.add(guide);
          }
        }).toList();
      } else {
        guides = guideSnap.docs;
      }
      return Right(guides);
    } catch (e) {
      return Left(e);
    }
  }
}
