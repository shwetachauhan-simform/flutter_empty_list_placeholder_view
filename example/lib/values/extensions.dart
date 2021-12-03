import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// provides extension to get a dependency from provider
extension ContextExtension on BuildContext {
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}

extension StatefulWidgetExtension on State {
  /// returns object of type [T] from provider
  T provide<T>() => Provider.of<T>(context, listen: false);

  /// allows to change field focus from one [FocusNode] to another
  void fieldFocusChange({required FocusNode from, required FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  bool get isDarkTheme => Theme.of(context).brightness == Brightness.dark;
}