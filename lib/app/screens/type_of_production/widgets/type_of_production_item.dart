import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucio/app/screens/type_of_production/type_of_production_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class TypeOfProductionItem extends ConsumerWidget {
  final ProductionTypeModel model;
  final bool showColors;
  final Widget? trailing;
  final bool item;

  const TypeOfProductionItem({Key? key, required this.model, this.showColors = false, this.trailing, this.item = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    final objectItem = ListTile(
      title: Text(
        model.name,
        style: TextStyle(color: showColors ? Color(model.color) : null),
      ),
      subtitle: item
          ? null
          : Text(
              "Days to be ready (${model.daysToBeReady})",
              style: TextStyle(color: showColors ? Color(model.color) : null, fontSize: 14),
            ),
      trailing: trailing ??
          ColorIndicator(
            width: 30,
            height: 30,
            borderRadius: 4,
            color: Color(model.color),
            onSelectFocus: false,
            onSelect: () async {
              final Color colorBeforeDialog = Color(model.color);
              Color result = await showColorPickerDialog(context, colorBeforeDialog);
              await ref.read(productionTypeModelProvider.notifier).update(model, values: {"color": result.value});
            },
          ),
      onLongPress: () => TypeOfProductionPage.fireForm(context, model: model),
    );

    return item
        ? objectItem
        : Slidable(
            // Specify a key if the Slidable is dismissible.
            key: ValueKey(model.id),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  spacing: 2,
                  onPressed: (_) async => await TypeOfProductionPage.fireDelete(context, model: model)
                      .then((bool value) => value == true ? ref.read(productionTypeModelProvider.notifier).delete([model]) : null),
                  backgroundColor: scheme.error,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
                ),
                const SizedBox(width: 1),
                SlidableAction(
                  onPressed: (_) => TypeOfProductionPage.fireForm(context, model: model),
                  backgroundColor: scheme.primary,
                  icon: Icons.edit,
                  label: 'Edit',
                  borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
                ),
                const SizedBox(width: 1),
              ],
            ),
            child: objectItem,
          );
  }
}
