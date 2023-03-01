// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class AppModel {
  bool _isInitialized = false;
  void initState(BuildContext context);
  void _init(BuildContext context) {
    if (!_isInitialized) {
      initState(context);
      _isInitialized = true;
    }
  }

  bool _disposeOnWidgetDisposal = true;
  void dispose();
  void canDispose() {
    if (_disposeOnWidgetDisposal) {
      dispose();
    }
  }

  bool _updateOnChange = false;

  VoidCallback _updateCallback = () {};
  void onUpdate() => _updateOnChange ? _updateCallback() : () {};
  AppModel setOnUpdate({
    bool updateOnChange = false,
    required VoidCallback onUpdate,
  }) {
    return this
      .._updateCallback = onUpdate
      .._updateOnChange = updateOnChange;
  }

  void updatePage(VoidCallback callback) {
    callback();
    _updateCallback();
  }
}

T createModel<T extends AppModel>(
  BuildContext context,
  T Function() defaultBuilder,
) {
  final model = context.read<T?>() ?? defaultBuilder();
  model._init(context);
  return model;
}
