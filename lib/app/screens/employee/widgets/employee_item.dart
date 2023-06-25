import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';

import 'package:lucio/domain/scheme/employe/employe_model.dart';

class EmployeeItem extends ConsumerWidget {
  final EmployeModel model;

  const EmployeeItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final options = ref.watch(optionsP);
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(model.id),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            spacing: 2,
            onPressed: (_) async =>
                await EmployeePage.fireDelete(context, model: model).then((bool value) => value == true ? ref.read(employeeProvider.notifier).delete([model]) : null),
            backgroundColor: scheme.error,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (_) => EmployeePage.fireForm(context, model: model),
            backgroundColor: scheme.primary,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
        ],
      ),
      child: FutureBuilder(
          future: model.real(startFilter: options.startFilter, endFilter: options.endFilter),
          builder: (_, real) {
            bool cumplido = (real.data ?? 0) >= model.plan;

            return ListTile(
              title: Text(model.name),
              subtitle: Text("Plan: ${real.data == null ? "" : "${real.data} /"} ${model.plan}"),
              onLongPress: () => EmployeePage.fireForm(context, model: model),
              leading: Icon(cumplido ? FontAwesomeIcons.check : FontAwesomeIcons.clock, color: cumplido ? scheme.primary : scheme.error),
              trailing: cumplido ? null : Text("${model.plan - (real.data ?? 0)}"),
            );
          }),
    );
  }
}
