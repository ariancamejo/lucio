import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class EmployeesPlanNotifier extends StateNotifier<List<EmployeePlanModel>> {
  Stream<void> tC = DBHelper.isar.employeePlanModels.watchLazy(fireImmediately: true);

  EmployeesPlanNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
    tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<EmployeePlanModel>> ref;

  Future<List<EmployeePlanModel>> findData() async => state = await DBHelper.isar.employeePlanModels.where().findAll();

  Future<EmployeePlanModel?> insert({required EmployeModel employee, required ProductionTypeModel type, required double plan, bool object = false}) async {
    ref.read(rlP.notifier).start();

    int index = state.indexWhere((element) => element.employee.value?.id == employee.id && element.type.value?.id == type.id);

    final obj = index == -1 ? EmployeePlanModel() : state[index]
      ..employee.value = employee
      ..plan = plan
      ..type.value = type;

    EmployeePlanModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.employeePlanModels.put(obj);
      await obj.employee.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.employeePlanModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    await ref.read(employeeProvider.notifier).findData();
    ref.refresh(employeeProvider);
    return result;
  }

  Future<EmployeePlanModel?> update(EmployeePlanModel obj, {required Map<String, dynamic> values, bool object = false}) async {
    ref.read(rlP.notifier).start();

    obj.employee.value = values['employee'] ?? obj.employee.value;
    obj.type.value = values['type'] ?? obj.type.value;
    obj.plan = values['plan'] ?? obj.plan;

    EmployeePlanModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.employeePlanModels.put(obj);
      await obj.employee.save();
      await obj.type.save();
      if (object) {
        result = await DBHelper.isar.employeePlanModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();
    await ref.read(employeeProvider.notifier).findData();
    ref.refresh(employeeProvider);
    return result;
  }

  Future<int> delete(List<EmployeePlanModel> obj) async {
    ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.employeePlanModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();
    await ref.read(employeeProvider.notifier).findData();
    ref.refresh(employeeProvider);
    return count;
  }
}

final employeePlanProvider = StateNotifierProvider<EmployeesPlanNotifier, List<EmployeePlanModel>>((ref) {
  return EmployeesPlanNotifier(ref);
});
