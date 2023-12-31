import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class WorkProductionItem extends ConsumerWidget {
  final WorkProductionModel model;
  final bool showProductionType;

  const WorkProductionItem({Key? key, required this.model, this.showProductionType = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(model.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              spacing: 8,
              onPressed: (_) {},
              backgroundColor: model.readyIn() == null ? scheme.primary : Colors.grey,
              label: model.readyIn() == null ? "Ready" : DateFormat(dateFormat).format(model.readyIn()!),
              borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
            ),
          ],
        ),
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
          title: showProductionType
              ? Text(
                  model.type.value?.name ?? "Production Type has delete",
                  style: TextStyle(color: Color(model.type.value?.color ?? 0x00000000)),
                )
              : Text(model.employee.value?.name ?? "Employee has deleted"),
          leading: model.type.value == null
              ? null
              : Icon(
                  model.readyIn() == null ? FontAwesomeIcons.check : FontAwesomeIcons.spinner,
                  color: model.readyIn() == null ? scheme.primary : Colors.grey,
                ),
          trailing: model.breaks == 0
              ? null
              : Text(
                  "- ${model.breaks}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
          subtitle: Text("${model.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
          onLongPress: () => ProductionTab.fireForm(context, model: model),
        ),
      ),
    );
  }
}
