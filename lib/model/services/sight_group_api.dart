import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';

class SightGroupApi {
  static Future<Either<Object, List>> getSightGroups() async {
    try {
      var queryData = await getIt<FirebaseFirestore>()
          .collection("SightGroup")
          .where("name", whereNotIn: ['featured'])
          .orderBy("name")
          .get();
      return Right(queryData.docs);
    } catch (e) {
      return Left(e);
    }
  }
}
