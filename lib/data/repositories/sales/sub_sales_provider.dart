import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SubSalesNotifier extends StateNotifier<List<SubSaleModel>> {
  Stream<void> tC = DBHelper.isar.subSaleModels.watchLazy(fireImmediately: true);

  SubSalesNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) => findData());
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<SubSaleModel>> ref;

  Future<List<SubSaleModel>> findData() async {
    DateTime startFilter = ref.read(optionsP).startFilter;
    DateTime endFilter = ref.read(optionsP).endFilter;
    state = await DBHelper.isar.subSaleModels.filter().datetimeBetween(startFilter, endFilter).findAll();
    DBHelper.isar.writeTxn(() async => DBHelper.isar.subSaleModels.filter().saleIsNull().deleteAll());
    return state;
  }

  Future<SubSaleModel?> insert({
    required SaleModel sale,
    required ProductionModel lot,
    required ProductionTypeModel type,
    required int quantity,
    required int breaks,
    bool object = false,
  }) async {
    ref.read(rlP.notifier).start();

    final obj = SubSaleModel()
      ..sale.value = sale
      ..lot.value = lot
      ..type.value = type
      ..quantity = quantity
      ..breaks = breaks;

    SubSaleModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.subSaleModels.put(obj);
      await obj.sale.save();
      await obj.lot.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.subSaleModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<SubSaleModel?> update(SubSaleModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.quantity = values['quantity'] ?? obj.quantity;
    obj.breaks = values['breaks'] ?? obj.breaks;
    obj.type.value = values['type'] ?? obj.type.value;
    obj.sale.value = values['sale'] ?? obj.sale.value;
    obj.lot.value = values['lot'] ?? obj.lot.value;

    SubSaleModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.subSaleModels.put(obj);
      await obj.sale.save();
      await obj.lot.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.subSaleModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<int> delete(List<SubSaleModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.subSaleModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();

    return count;
  }
}

final subSalesProvider = StateNotifierProvider<SubSalesNotifier, List<SubSaleModel>>((ref) {
  return SubSalesNotifier(ref);
});