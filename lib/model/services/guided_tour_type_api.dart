import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';
import 'package:krtouristic/model/core/guided_tour_type.dart';

class GuidedTourTypeApi {
  static Future<Either<Object, List>> getGuidedTourTypes() async {
    try {
      var guidedTourTypeRef = getIt<FirebaseFirestore>()
          .collection("GuidedTourType")
          .orderBy("name")
          .withConverter(
            fromFirestore: GuidedTourType.fromFirestore,
            toFirestore: (GuidedTourType guidedTourType, _) =>
                guidedTourType.toFirestore(),
          );
      final guidedTourTypeDocSnap = await guidedTourTypeRef.get();
      return Right(guidedTourTypeDocSnap.docs);
    } catch (e) {
      return Left(e);
    }
  }
}
