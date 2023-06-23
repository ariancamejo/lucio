import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/employee/form/employee_form.dart';
import 'package:lucio/app/screens/employee/widgets/employee_item.dart';
import 'package:lucio/app/widgets/empty.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';

import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EmployeePage extends ConsumerWidget {
  static String name = 'EmployeePage';

  const EmployeePage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {EmployeModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => EmployeeForm(model: model),
      );

  static Future<bool> fireDelete(BuildContext context, {required EmployeModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove employee with name '${model.name}'"),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(employeeProvider.notifier).findData(),
        child: employees.isEmpty
            ? EmptyScreen(
                name: "Employee",
                onTap: () => fireForm(context),
              )
            : ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(height: 1),
                itemBuilder: (_, index) => EmployeeItem(model: employees[index]),
                itemCount: employees.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
