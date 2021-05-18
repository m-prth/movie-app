import 'package:flutter/material.dart';

class Tab {
  final int index;
  final String title;

  const Tab({@required this.index, @required this.title})
      : assert(index >= 0, 'index cannot be negative'),
        assert(title != null, 'title cannot be null');
}
