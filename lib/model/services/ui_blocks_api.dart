import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';

class UiBlocksApi {
  static Future<Either<Object, List>> getHomePageBlocks() async {
    try {
      var queryData = await getIt<FirebaseFirestore>()
          .collection("HomePageBlock")
          .orderBy("sort_order")
          .get();
      return Right(queryData.docs);
    } catch (e) {
      return Left(e);
    }
  }
}
