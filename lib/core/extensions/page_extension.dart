import 'package:flutter/material.dart';

extension PageExtension on Widget {
  Route route() {
    return MaterialPageRoute(builder: (_) => this);
  }
}