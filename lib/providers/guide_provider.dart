import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/core/guide.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/guide_helper.dart';

class GuideProvider {
  final _helper = GuideHelper();
  final _streamController = StreamController<Either<Glitch, List<Guide>>>();
  Stream<Either<Glitch, List<Guide>>> get guideStream {
    return _streamController.stream;
  }

  Future<void> getAllGuides() async {
    final guideHelperResult = await _helper.getGuides();
    _streamController.add(guideHelperResult);
  }
}
