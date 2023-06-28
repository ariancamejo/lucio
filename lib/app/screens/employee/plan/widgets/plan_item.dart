import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/screens/employee/plan/plan_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employee_plan_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';

class PlanItem extends ConsumerWidget {
  final bool shoeEmployee;
  final EmployeePlanModel model;

  const PlanItem({Key? key, required this.model, this.shoeEmployee = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final options = ref.watch(optionsP);
    return FutureBuilder(
      future: model.employee.value?.real(model.type.value!, startFilter: options.startFilter, endFilter: options.endFilter),
      builder: (_, snap) {
        bool cumplido = (snap.data ?? 0) >= model.plan;

        double percent = (snap.data ?? 0) / model.plan;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultRefNumber),
            gradient: LinearGradient(
              stops: [percent, percent > 0.99 ? 1 : percent + 0.1],
              colors: [percent >= 0.01 ? scheme.onSecondary : scheme.background, scheme.background],
            ),
          ),
          child: Slidable(
              // Specify a key if the Slidable is dismissible.
              key: ValueKey(model.id),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    spacing: 2,
                    onPressed: (_) async =>
                        await PlanPage.fireDelete(context, model: model).then((bool value) => value == true ? ref.read(employeePlanProvider.notifier).delete([model]) : null),
                    backgroundColor: scheme.error,
                    icon: Icons.delete,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
                  ),
                  const SizedBox(width: 1),
                  SlidableAction(
                    onPressed: (_) => PlanPage.fireForm(context, model: model),
                    backgroundColor: scheme.primary,
                    icon: Icons.edit,
                    label: 'Edit',
                    borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
                  ),
                  const SizedBox(width: 1),
                ],
              ),
              child: Tooltip(
                message: model.type.value?.name ?? "",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: shoeEmployee ? Text(model.employee.value?.name ?? "") : Text(model.type.value?.name ?? ""),
                      subtitle: Text(
                        "Plan: ${snap.data == null ? "" : "${snap.data} /"} ${model.plan}",
                        style: TextStyle(color: shoeEmployee ? Color(model.type.value?.color ?? 0x00000000) : null),
                      ),
                      leading: Icon(cumplido ? FontAwesomeIcons.check : FontAwesomeIcons.clock, color: cumplido ? scheme.primary : scheme.error),
                      trailing: Text(
                        "${(model.plan - (snap.data ?? 0)).abs()}",
                        style: TextStyle(
                          color: cumplido ? Colors.green : scheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(kDefaultRefNumber),
                    //     child: LinearProgressIndicator(
                    //       value: (snap.data ?? 0) / model.plan,
                    //       valueColor: AlwaysStoppedAnimation(cumplido ? Colors.green : scheme.error),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )),
        );
      },
    );
  }
}
