import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/core/guided_tour.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/guided_tour_helper.dart';

class GuidedTourProvider {
  final _helper = GuidedTourHelper();
  final _streamController =
      StreamController<Either<Glitch, List<GuidedTour>>>();
  Stream<Either<Glitch, List<GuidedTour>>> get guidedTourStream {
    return _streamController.stream;
  }

  Future<void> getGuidedTours() async {
    final guidedToursHelperResult = await _helper.getGuidedTours();
    _streamController.add(guidedToursHelperResult);
  }
}
