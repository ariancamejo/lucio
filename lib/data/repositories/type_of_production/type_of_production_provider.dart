import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class TypeOfSaleNotifier extends StateNotifier<List<ProductionTypeModel>> {
  Stream<void> tC = DBHelper.isar.productionTypeModels.watchLazy(fireImmediately: true);

  TypeOfSaleNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
        tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<ProductionTypeModel>> ref;

  Future<List<ProductionTypeModel>> findData({String? name}) async =>
      state = await DBHelper.isar.productionTypeModels.filter().optional(name != null, (q) => q.nameContains(name ?? "")).findAll();

  Future<ProductionTypeModel?> insert({required String name, required int color, required int daysToBeReady, required double price, bool object = false}) async {
    ref.read(rlP.notifier).start();
    final obj = ProductionTypeModel()
      ..name = name
      ..price = price
      ..daysToBeReady = daysToBeReady
      ..color = color;

    ProductionTypeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.productionTypeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.productionTypeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<ProductionTypeModel?> update(ProductionTypeModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.name = values['name'] ?? obj.name;
    obj.price = values['price'] ?? obj.price;
    obj.daysToBeReady = values['daysToBeReady'] ?? obj.daysToBeReady;
    obj.color = values['color'] ?? obj.color;
    ProductionTypeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.productionTypeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.productionTypeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<int> delete(List<ProductionTypeModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.productionTypeModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final productionTypeModelProvider = StateNotifierProvider<TypeOfSaleNotifier, List<ProductionTypeModel>>((ref) {
  return TypeOfSaleNotifier(ref);
});
