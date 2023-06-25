import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ProductionNotifier extends StateNotifier<List<ProductionModel>> {
  Stream<void> tC = DBHelper.isar.productionModels.watchLazy(fireImmediately: true);

  ProductionNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
        tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<ProductionModel>> ref;

  Future<List<ProductionModel>> findData({String? name}) async {
    DateTime startFilter = ref.read(optionsP).startFilter;
    DateTime endFilter = ref.read(optionsP).endFilter;
    state = await DBHelper.isar.productionModels.filter().dateBetween(startFilter, endFilter).sortByDateDesc().findAll();
    ref.read(workProductionProvider.notifier).findData();
    return state;
  }

  Future<ProductionModel?> insert({required DateTime dateTimeParam, bool object = false}) async {
      ref.read(rlP.notifier).start(); 
    DateTime datetime = DateTime(dateTimeParam.year, dateTimeParam.month, dateTimeParam.day);
    final obj = ProductionModel()..date = datetime;

    ProductionModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.productionModels.put(obj);
      if (object) {
        result = await DBHelper.isar.productionModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    return result;
  }

  Future<ProductionModel?> findProduction(DateTime dateTimeParam) async {
    List<ProductionModel> list = await DBHelper.isar.productionModels.where().findAll();
    DateFormat format = DateFormat(dateFormat);

    List<ProductionModel> coinciden = list.where((element) => format.format(element.date) == format.format(dateTimeParam)).toList();
    if (coinciden.length > 1) {
      BuildContext? context = Utils.currentContext(ref);
      if (context != null && context.mounted) {
        Utils.showSnack(context, title: "Two Production of some Day", message: "Please, contact your developer");
      }
      return coinciden.first;
    }
    if (coinciden.length == 1) {
      return coinciden.first;
    }

    return insert(dateTimeParam: dateTimeParam, object: true);
  }

  Future<int> delete(List<ProductionModel> obj) async {
      ref.read(rlP.notifier).start(); 
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.productionModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    return count;
  }
}

final productionProvider = StateNotifierProvider<ProductionNotifier, List<ProductionModel>>((ref) {
  return ProductionNotifier(ref);
});
