import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lucio/app/screens/employee/plan/form/plan_form.dart';
import 'package:lucio/app/screens/employee/plan/widgets/plan_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/employe/employee_plan_provider.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PlanPage extends ConsumerStatefulWidget {
  static String name = 'PlanPage';
  final int? employeeId;

  static fireForm(BuildContext context, {EmployeePlanModel? model, EmployeModel? employeModelInitial}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => PlanForm(model: model, employeModelInitial: employeModelInitial),
      );

  static Future<bool> fireDelete(BuildContext context, {required EmployeePlanModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove Plan of '${model.employee.value?.name ?? ""}'"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    return res ?? false;
  }

  const PlanPage({Key? key, this.employeeId}) : super(key: key);

  @override
  ConsumerState<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends ConsumerState<PlanPage> {
  EmployeModel? employeModel;
  bool loading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    if (widget.employeeId != null) {
      employeModel = await DBHelper.isar.employeModels.filter().idEqualTo(widget.employeeId!).findFirst();
    }
    Future.microtask(() => setState(() => loading = false));
  }

  @override
  Widget build(BuildContext context) {
    List<EmployeePlanModel> employeesPlan = ref.watch(employeePlanProvider);
    print(employeesPlan);
    if (employeModel != null) {
      employeesPlan = employeesPlan.where((element) => element.employee.value?.id == employeModel?.id).toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees Plan"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : RefreshIndicator(
              onRefresh: () async => await ref.read(employeeProvider.notifier).findData(),
              child: employeesPlan.isEmpty
                  ? EmptyScreen(
                      name: "Employee Plan",
                      onTap: () => PlanPage.fireForm(context),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, index) => const SizedBox(height: 1),
                      itemBuilder: (_, index) => PlanItem(model: employeesPlan[index]),
                      itemCount: employeesPlan.length,
                    ),
            ),
      floatingActionButton: FloatingActionButton(onPressed: () => PlanPage.fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
