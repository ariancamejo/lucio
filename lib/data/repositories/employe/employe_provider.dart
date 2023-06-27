import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/rlp_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';

class EmployeesNotifier extends StateNotifier<List<EmployeModel>> {
  Stream<void> tC = DBHelper.isar.employeModels.watchLazy(fireImmediately: true);

  EmployeesNotifier(this.ref) : super([]) {
    tC.asBroadcastStream();
        tC.listen((event) => Future.microtask(() => findData()));
    findData();
  }

  late StateNotifierProviderRef<StateNotifier, List<EmployeModel>> ref;

  Future<List<EmployeModel>> findData({String? name, String? ci, double? plan}) async => state = await DBHelper.isar.employeModels
      .filter()
      .optional(
        name != null,
        (q) => q.nameContains(name ?? ""),
      )
      .optional(
        ci != null,
        (q) => q.ciContains(ci ?? ""),
      )
      .optional(
        plan != null,
        (q) => q.planGreaterThan(plan ?? 0),
      )
      .findAll();

  Future<EmployeModel?> insert({required String name, required String ci, required double plan, bool object = false}) async {
      ref.read(rlP.notifier).start();
    final obj = EmployeModel()
      ..name = name
      ..ci = ci
      ..plan = plan;

    EmployeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.employeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.employeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<EmployeModel?> update(EmployeModel obj, {required Map<String, dynamic> values, bool object = false}) async {
      ref.read(rlP.notifier).start();

    obj.name = values['name'] ?? obj.name;
    obj.ci = values['ci'] ?? obj.ci;
    obj.plan = values['plan'] ?? obj.plan;
    EmployeModel? result;
    await DBHelper.isar.writeTxn(() async {
      final id = await DBHelper.isar.employeModels.put(obj);
      if (object) {
        result = await DBHelper.isar.employeModels.get(id);
      }
    });
    ref.read(rlP.notifier).stop();

    return result;
  }

  Future<int> delete(List<EmployeModel> obj) async {
      ref.read(rlP.notifier).start();
    late int count;
    await DBHelper.isar.writeTxn(() async {
      count = await DBHelper.isar.employeModels.deleteAll(obj.map((e) => e.id).toList());
    });
    ref.read(rlP.notifier).stop();

    return count;
  }
}

final employeeProvider = StateNotifierProvider<EmployeesNotifier, List<EmployeModel>>((ref) {
  return EmployeesNotifier(ref);
});
