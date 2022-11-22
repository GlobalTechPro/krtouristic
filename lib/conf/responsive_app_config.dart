import 'package:flutter/material.dart';

class ResponsiveAppConfig {
  final BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  ResponsiveAppConfig(this._context) {
    MediaQueryData queryData = MediaQuery.of(_context);
    _height = queryData.size.height / 100.0;
    _width = queryData.size.width / 100.0;
    _heightPadding =
        _height - ((queryData.padding.top + queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (queryData.padding.left + queryData.padding.right) / 100.0;
  }

  double rHeight(double percentage) {
    return _height * percentage;
  }

  double rWidth(double percentage) {
    return _width * percentage;
  }

  double rHeightPadding(double percentage) {
    return _heightPadding * percentage;
  }

  double rWidthPadding(double percentage) {
    return _widthPadding * percentage;
  }
}
