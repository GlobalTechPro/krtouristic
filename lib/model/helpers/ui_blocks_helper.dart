import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/model/services/ui_blocks_api.dart';

class UiBlocksHelper {
  Future<Either<Glitch, List>> getHomePageBlocks() async {
    final apiResult = await UiBlocksApi.getHomePageBlocks();
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
