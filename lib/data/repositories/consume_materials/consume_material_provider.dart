import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ConsumeMaterialsNotifier extends StateNotifier<List<ConsumptionModel>> {
  Stream<void> tC = DBHelper.isar.consumptionModels.watchLazy(fireImmediately: true);

  ConsumeMaterialsNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<ConsumptionModel>> ref;

  Future<List<ConsumptionModel>> findData() async => state = await DBHelper.isar.consumptionModels.where().findAll();

  Future<ConsumptionModel?> insert({
    required ProductionTypeModel type,
    required MaterialModel material,
    required double quantityType,
    required double quantityMaterial,
    bool object = false,
  }) async {
    ref.read(rlP.notifier).start();
    ConsumptionModel? exist = await DBHelper.isar.consumptionModels.filter().type((q) => q.idEqualTo(type.id)).material((q) => q.idEqualTo(material.id)).findFirst();
    if (exist != null) {
      BuildContext? context = Utils.currentContext(ref);
      if (context != null && context.mounted) {
        Utils.showSnack(context, title: "Warning", message: "You have edited an exist object");
      }

      return update(exist, values: {
        "quantityType": quantityType,
        "quantityMaterial": quantityMaterial,
      });
    }

    final obj = ConsumptionModel()
      ..type.value = type
      ..material.value = material
      ..quantityType = quantityType
      ..quantityMaterial = quantityMaterial;

    ConsumptionModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.consumptionModels.put(obj);
      await obj.type.save();
      await obj.material.save();

      if (object) {
        result = await DBHelper.isar.consumptionModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<ConsumptionModel?> update(ConsumptionModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();
    obj.type.value = values['type'] ?? obj.type.value;
    obj.material.value = values['material'] ?? obj.material.value;
    obj.quantityType = values['quantityType'] ?? obj.quantityType;
    obj.quantityMaterial = values['quantityMaterial'] ?? obj.quantityMaterial;

    ConsumptionModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.consumptionModels.put(obj);
      obj.type.save();
      obj.material.save();
      if (object) {
        result = await DBHelper.isar.consumptionModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<int> delete(List<ConsumptionModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.consumptionModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final consumeMaterialsProvider = StateNotifierProvider<ConsumeMaterialsNotifier, List<ConsumptionModel>>((ref) {
  return ConsumeMaterialsNotifier(ref);
});
