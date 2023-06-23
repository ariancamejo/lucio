import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';

import 'package:lucio/domain/scheme/sale/sale_model.dart';

class TypeOfSaleNotifier extends StateNotifier<List<SaleTypeModel>> {
  Stream<void> tC = DBHelper.isar.saleTypeModels.watchLazy(fireImmediately: true);

  TypeOfSaleNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) {
      findData();
    });
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<SaleTypeModel>> ref;

  Future<List<SaleTypeModel>> findData({String? name}) async =>
      state = await DBHelper.isar.saleTypeModels.filter().optional(name != null, (q) => q.nameContains(name ?? "")).findAll();

  Future<SaleTypeModel?> insert( {required String name,bool object = false}) async {
      ref.read(rlP.notifier).start();
    final obj = SaleTypeModel()..name = name;

    SaleTypeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.saleTypeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.saleTypeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<SaleTypeModel?> update(SaleTypeModel obj, {required Map<String, dynamic> values, bool object = false}) async {
      ref.read(rlP.notifier).start();
    String name = values['name'] ?? obj.name;
    obj.name = name;
    SaleTypeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.saleTypeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.saleTypeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<int> delete(List<SaleTypeModel> obj) async {
      ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.saleTypeModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final saleTypeModelProvider = StateNotifierProvider<TypeOfSaleNotifier, List<SaleTypeModel>>((ref) {
  return TypeOfSaleNotifier(ref);
});
