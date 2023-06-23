import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isar/isar.dart';

import 'package:lucio/data/repositories/options_provider.dart';

import 'package:lucio/data/repositories/rlp_provider.dart';

import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SaleNotifier extends StateNotifier<List<SaleModel>> {
  Stream<void> tC = DBHelper.isar.saleModels.watchLazy(fireImmediately: true);

  SaleNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) {
      findData();
    });
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<SaleModel>> ref;

  Future<List<SaleModel>> findData({String? name}) async {
    DateTime startFilter = ref.read(optionsP).startFilter;
    DateTime endFilter = ref.read(optionsP).endFilter;
    state = await DBHelper.isar.saleModels.filter().dateBetween(startFilter, endFilter).sortByDateDesc().findAll();
    return state;
  }

  Future<SaleModel?> insert({required String client, bool object = false}) async {
    ref.read(rlP.notifier).start();

    final obj = SaleModel()..client = client;

    SaleModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.saleModels.put(obj);
      if (object) {
        result = await DBHelper.isar.saleModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<SaleModel?> update(SaleModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.client = values['client'] ?? obj.client;
    obj.deposit = values['deposit'] ?? obj.deposit;
    SaleModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.saleModels.put(obj);
      if (object) {
        result = await DBHelper.isar.saleModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<int> delete(List<SaleModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.saleModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final saleProvider = StateNotifierProvider<SaleNotifier, List<SaleModel>>((ref) {
  return SaleNotifier(ref);
});
