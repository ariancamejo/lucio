import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class WorkProductionItem extends ConsumerWidget {
  final WorkProductionModel model;

  const WorkProductionItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
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
                await ProductionTab.fireDelete(context, model: model).then((bool value) => value == true ? ref.read(workProductionProvider.notifier).delete([model]) : null),
            backgroundColor: scheme.error,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (_) => ProductionTab.fireForm(context, model: model),
            backgroundColor: scheme.primary,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
        ],
      ),
      child: ListTile(
        title: Text(model.employee.value?.name ?? "Employee has deleted"),
        trailing: Container(
          constraints: const BoxConstraints(maxWidth: 45),
          height: 30,
          decoration: BoxDecoration(color: Color(model.type.value?.color ?? 0x00000000), borderRadius: BorderRadius.circular(kDefaultRefNumber / 4)),
          child: model.breaks == 0
              ? null
              : Center(
                  child: Text(
                    "- ${model.breaks}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        ),
        subtitle: Text("${model.type.value?.name ?? ""} -->  ${model.quantity}"),
        onLongPress: () => ProductionTab.fireForm(context, model: model),
      ),
    );
  }
}
