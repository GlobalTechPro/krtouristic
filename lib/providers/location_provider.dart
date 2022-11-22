import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/core/location.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/location_helper.dart';

class LocationProvider {
  final _helper = LocationHelper();
  final _streamController = StreamController<Either<Glitch, List<Location>>>();
  Stream<Either<Glitch, List<Location>>> get locationStream {
    return _streamController.stream;
  }

  Future<void> getLocations() async {
    final locationsHelperResult = await _helper.getLocations();
    _streamController.add(locationsHelperResult);
  }
}
