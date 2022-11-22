import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/sight_group_helper.dart';

class SightGroupProvider {
  final _helper = SightGroupHelper();
  final _streamController = StreamController<Either<Glitch, List>>();
  Stream<Either<Glitch, List>> get sightGroupStream {
    return _streamController.stream;
  }

  Future<void> getSightGroups() async {
    final sightGroupHelperResult = await _helper.getSightGroups();
    _streamController.add(sightGroupHelperResult);
  }
}
