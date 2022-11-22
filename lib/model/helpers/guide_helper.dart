import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/model/core/guide.dart';
import 'package:krtouristic/model/services/guide_api.dart';

class GuideHelper {
  Future<Either<Glitch, List<Guide>>> getGuides({
    int? cityId,
    String? lang,
    String? searchStr,
  }) async {
    int city = cityId ?? globals.cityId;
    String language = lang ?? globals.lang;
    final apiResult = await GuideApi.getGuides(
      cityId: city,
      lang: language,
      searchStr: searchStr,
    );
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      List<Guide> guides = [];
      r.map((guide) {
        guides.add(Guide.fromFirestore(guide, null));
      }).toList();
      return Right(guides);
    });
  }
}
