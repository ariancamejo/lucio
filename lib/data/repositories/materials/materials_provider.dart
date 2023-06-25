import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

class MaterialsNotifier extends StateNotifier<List<MaterialModel>> {
  Stream<void> tC = DBHelper.isar.materialModels.watchLazy(fireImmediately: true);

  MaterialsNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
        tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<MaterialModel>> ref;

  Future<List<MaterialModel>> findData() async => state = await DBHelper.isar.materialModels.where().findAll();

  Future<MaterialModel?> insert({required String name, required int color, required UnitOfMeasurementModel unit, bool object = false}) async {
    ref.read(rlP.notifier).start();
    final obj = MaterialModel()
      ..name = name
      ..unit.value = unit
      ..color = color;

    MaterialModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.materialModels.put(obj);
      await obj.unit.save();
      if (object) {
        result = await DBHelper.isar.materialModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    ref.refresh(consumeMaterialsProvider);
    return result;
  }

  Future<MaterialModel?> update(MaterialModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.name = values['name'] ?? obj.name;
    obj.color = values['color'] ?? obj.color;
    obj.unit.value = values['unit'] ?? obj.unit.value;
    MaterialModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.materialModels.put(obj);
      await obj.unit.save();
      if (object) {
        result = await DBHelper.isar.materialModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    ref.refresh(consumeMaterialsProvider);
    return result;
  }

  Future<int> delete(List<MaterialModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.materialModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    ref.refresh(consumeMaterialsProvider);
    return count;
  }
}

final materialsProvider = StateNotifierProvider<MaterialsNotifier, List<MaterialModel>>((ref) {
  return MaterialsNotifier(ref);
});
