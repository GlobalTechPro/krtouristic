import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/glitch/resource_unavailable_glitch.dart';
import 'package:krtouristic/conf/globals.dart' as globals;
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/services/location_api.dart';

class LocationHelper {
  Future<Either<Glitch, Location>> getLocation({required String id}) async {
    final apiResult = await LocationApi.getLocation(locationId: id);
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      return Right(r);
    });
  }

  Future<Either<Glitch, List<Location>>> getLocations({
    int? cityId,
    String? lang,
    String? searchStr,
    String? locationType,
    String? sightGroup,
    bool? top,
  }) async {
    int city = cityId ?? globals.cityId;
    String language = lang ?? globals.lang;
    final apiResult = await LocationApi.getLocations(
        cityId: city,
        lang: language,
        searchStr: searchStr,
        locationTypeName: locationType,
        sightGroupName: sightGroup,
        top: top);
    return apiResult.fold((l) {
      // @TODO analyze exceptions and return appropriate glitch instance
      return Left(ResourceUnavailableGlitch());
    }, (r) {
      List<Location> locations = [];
      r.map((location) {
        locations.add(Location.fromFirestore(location, null));
      }).toList();
      return Right(locations);
    });
  }
}
