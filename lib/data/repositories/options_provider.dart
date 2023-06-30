import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/production/production_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/device/helpers/storage/secure.dart';

part 'options_provider.freezed.dart';

@freezed
class OptionsState with _$OptionsState {
  const factory OptionsState({
    required DateTime startFilter,
    required DateTime endFilter,
    @Default(3) int decimals,
    @Default(false) bool checkAuth,
    @Default(0) int daysOfRangeDateProduction,
  }) = _OptionsState;

  const OptionsState._();
}

class OptionsNotifier extends StateNotifier<OptionsState> {
  StateNotifierProviderRef<OptionsNotifier, OptionsState> ref;

  set checkAuth(value) => state = state.copyWith(checkAuth: value);

  OptionsNotifier(this.ref)
      : super(
          OptionsState(
            startFilter: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              1,
            ),
            endFilter: DateTime(
              DateTime.now().year,
              DateTime.now().month + 1,
              0,
            ),
          ),
        ) {
    Future.microtask(() => _init());
  }

  set daysOfRangeDateProduction(int value) {
    state = state.copyWith(daysOfRangeDateProduction: value);
    _save();
  }

  set decimals(int value) {
    state = state.copyWith(decimals: value);
    _save();
  }

  set dateRange(DateTimeRange? dateTimeRange) {
    if (dateTimeRange != null) {
      state = state.copyWith(
        startFilter: DateTime(dateTimeRange.start.year, dateTimeRange.start.month, dateTimeRange.start.day, 0, 0, 0, 0),
        endFilter: DateTime(dateTimeRange.end.year, dateTimeRange.end.month, dateTimeRange.end.day, 23, 59, 59, 999),
      );
      _save();

      ref.read(productionProvider.notifier).findData();
      ref.read(workProductionProvider.notifier).findData();
      ref.read(saleProvider.notifier).findData();
      ref.read(subSalesProvider.notifier).findData();
    }
    return;
  }

  _save() async {
    Map<String, dynamic> json = {
      "daysOfRangeDateProduction": state.daysOfRangeDateProduction,
      "decimals": state.decimals,
    };
    await SecureStorage.set('optionsSaved', value: jsonEncode(json));
  }

  _init() async {
    final strOptionsSaved = await SecureStorage.read('optionsSaved');
    if (strOptionsSaved != null) {
      Map<String, dynamic> json = jsonDecode(strOptionsSaved);
      state = state.copyWith(daysOfRangeDateProduction: json['daysOfRangeDateProduction'], decimals: json['decimals']);
    }
  }
}

final optionsP = StateNotifierProvider<OptionsNotifier, OptionsState>((ref) {
  return OptionsNotifier(ref);
});
