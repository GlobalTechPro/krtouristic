import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:krtouristic/model/services/guided_tour_api.dart';

class GuidedTourHelper {
  Future<Either<Glitch, GuidedTour>> getTourById({required String id}) async {
    final apiResult = await GuidedTourApi.getTourById(tourId: id);
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      return Right(r);
    });
  }

  Future<Either<Glitch, List<GuidedTour>>> getGuidedTours({
    int? cityId,
    String? lang,
    String? searchStr,
    String? guideName,
    String? guidedTourTypeName,
    bool? top,
  }) async {
    int city = cityId ?? globals.cityId;
    String language = lang ?? globals.lang;
    final apiResult = await GuidedTourApi.getGuidedTours(
        cityId: city,
        lang: language,
        searchStr: searchStr,
        guideName: guideName,
        guidedTourTypeName: guidedTourTypeName,
        top: top);
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      List<GuidedTour> guidedTours = [];
      r.map((guidedTour) {
        guidedTours.add(GuidedTour.fromFirestore(guidedTour, null));
      }).toList();
      return Right(guidedTours);
    });
  }
}
