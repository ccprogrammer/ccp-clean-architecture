import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get _size => mediaQuery.size;

  double get width => _size.width;

  double get height => _size.height;
}
