import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:krtouristic/model/glitch/glitch.dart';
import 'package:krtouristic/model/helpers/ui_blocks_helper.dart';

class UiBlocksProvider {
  final _helper = UiBlocksHelper();
  final _streamController = StreamController<Either<Glitch, List>>();
  Stream<Either<Glitch, List>> get uiBlocksStream {
    return _streamController.stream;
  }

  Future<void> getHomePageBlocks() async {
    final uiHomeBlocksHelperResult = await _helper.getHomePageBlocks();
    _streamController.add(uiHomeBlocksHelperResult);
  }
}
