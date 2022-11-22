import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krtouristic/utils/injection/injection.dart';
import 'package:krtouristic/conf/globals.dart' as globals;

class CityApi {
  static Future<Either<Object, Map<String, dynamic>>> loadCityBasicData(
      {int? cityId, String? lang}) async {
    int city = cityId ?? globals.cityId;
    String language = lang ?? globals.lang;
    try {
      final cityDocRef = getIt<FirebaseFirestore>()
          .collection("City")
          .where("id", isEqualTo: city)
          .where("lang", isEqualTo: language);
      final citySnap = await cityDocRef.get();
      final extractedCityData = citySnap.docs[0].data();
      globals.cityData = extractedCityData;
      return Right(extractedCityData);
    } catch (e) {
      return Left(e);
    }
  }
}
