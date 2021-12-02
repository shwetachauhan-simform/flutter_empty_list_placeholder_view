import 'package:flutter/material.dart';

double devicePixelRatio = 0.0;

/// provides extension to use dynamic sizes
// ignore_for_file: type_annotate_public_apis
extension SdpExtenstion on num {
  /// provides display density based sizes
  double get sdp => (this * 0.75 + devicePixelRatio).toDouble();
}

/// provides extension to get a dependency from provider
extension ContextExtension on BuildContext {
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
