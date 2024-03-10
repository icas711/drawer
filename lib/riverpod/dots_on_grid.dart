import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onGridProvider = NotifierProvider<OnGridNotifier, List<Offset>>(OnGridNotifier.new);

class OnGridNotifier extends Notifier<List<Offset>> {
  @override
  List<Offset> build() => [];

  void add(Offset value) {
    state = [
      ...state,
      value
    ];
  }

  void addAll(List<Offset> value) {
    state = state..addAll(value);
  }

  void clear() {
    state = [];
  }



}