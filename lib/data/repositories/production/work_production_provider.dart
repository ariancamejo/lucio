import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/production_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/device.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class WorkProductionNotifier extends StateNotifier<List<WorkProductionModel>> {
  Stream<void> tC = DBHelper.isar.workProductionModels.watchLazy(fireImmediately: true);

  WorkProductionNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<WorkProductionModel>> ref;

  Future<List<WorkProductionModel>> findData() async {
    DateTime startFilter = ref.read(optionsP).startFilter;
    DateTime endFilter = ref.read(optionsP).endFilter;
    state = await DBHelper.isar.workProductionModels.filter().datetimeBetween(startFilter, endFilter).findAll();
    DBHelper.isar.writeTxn(() async => DBHelper.isar.workProductionModels.filter().productionIsNull().deleteAll());
    return state;
  }

  Future<WorkProductionModel?> insert({
    required EmployeModel employee,
    required ProductionTypeModel type,
    DateTime? dateTimeParam,
    required int quantity,
    required int breaks,
    bool object = false,
  }) async {
    ref.read(rlP.notifier).start();
    DateTime now = dateTimeParam ?? DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day);

    ProductionModel? productionModel = await ref.read(productionProvider.notifier).findProduction(dateTime);
    if (productionModel == null) {
      BuildContext? context = Utils.currentContext(ref);
      if (context != null && context.mounted) {
        Utils.showSnack(context, title: "Two Production of some Day", message: "Please, contact your developer");
      }
      return null;
    }

    final obj = WorkProductionModel()
      ..production.value = productionModel
      ..employee.value = employee
      ..type.value = type
      ..datetime = now
      ..listForSale = dateTime.add(Duration(days: type.daysToBeReady))
      ..quantity = quantity
      ..breaks = breaks;

    WorkProductionModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.workProductionModels.put(obj);
      await obj.production.save();
      await obj.employee.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.workProductionModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<WorkProductionModel?> update(WorkProductionModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.quantity = values['quantity'] ?? obj.quantity;
    obj.breaks = values['breaks'] ?? obj.breaks;
    obj.type.value = values['type'] ?? obj.type.value;
    obj.employee.value = values['employee'] ?? obj.employee.value;

    WorkProductionModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.workProductionModels.put(obj);
      await obj.employee.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.workProductionModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<int> delete(List<WorkProductionModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.workProductionModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();

    return count;
  }
}

final workProductionProvider = StateNotifierProvider<WorkProductionNotifier, List<WorkProductionModel>>((ref) {
  return WorkProductionNotifier(ref);
});
