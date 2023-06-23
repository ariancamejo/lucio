import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

part 'units_provider.freezed.dart';

@freezed
class UnitsState with _$UnitsState {
  const factory UnitsState({UnitOfMeasurementModel? selected, @Default([]) List<UnitOfMeasurementModel> units}) = _UnitsState;

  const UnitsState._();
}

class UnitsNotifier extends StateNotifier<UnitsState> {
  Stream<void> tC = DBHelper.isar.unitOfMeasurementModels.watchLazy(fireImmediately: true);

  UnitsNotifier(this.ref) : super(const UnitsState()) {
    tC.asBroadcastStream();
    tC.listen((event) {
      findData();
    });
    findData().then((value) => state = state.copyWith(selected: value.isEmpty ? null : value.first));
  }

  late StateNotifierProviderRef<StateNotifier, UnitsState> ref;

  set selected(value) => state = state.copyWith(selected: value);

  Future<List<UnitOfMeasurementModel>> findData() async {
    List<UnitOfMeasurementModel> list = await DBHelper.isar.unitOfMeasurementModels.where().findAll();
    state = state.copyWith(units: list);
    return state.units;
  }

  Future<UnitOfMeasurementModel?> insert({required String key, required String value, bool object = false}) async {
    ref.read(rlP.notifier).start();
    final obj = UnitOfMeasurementModel()
      ..key = key
      ..value = value;

    UnitOfMeasurementModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.unitOfMeasurementModels.put(obj);
      if (object) {
        result = await DBHelper.isar.unitOfMeasurementModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<UnitOfMeasurementModel?> update(UnitOfMeasurementModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.key = values['key'] ?? obj.key;
    obj.value = values['value'] ?? obj.value;
    UnitOfMeasurementModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.unitOfMeasurementModels.put(obj);
      if (object) {
        result = await DBHelper.isar.unitOfMeasurementModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<int> delete(List<UnitOfMeasurementModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.unitOfMeasurementModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final unitsProvider = StateNotifierProvider<UnitsNotifier, UnitsState>((ref) {
  return UnitsNotifier(ref);
});
