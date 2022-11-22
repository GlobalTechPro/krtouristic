import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/model/services/guided_tour_type_api.dart';

class GuidedTourTypeHelper {
  Future<Either<Glitch, List>> getGuidedTourTypes() async {
    final apiResult = await GuidedTourTypeApi.getGuidedTourTypes();
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
