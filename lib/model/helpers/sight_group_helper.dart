import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/model/services/sight_group_api.dart';

class SightGroupHelper {
  Future<Either<Glitch, List>> getSightGroups() async {
    final apiResult = await SightGroupApi.getSightGroups();
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
