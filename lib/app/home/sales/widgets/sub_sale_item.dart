import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';

import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SubSaleItem extends ConsumerWidget {
  final SubSaleModel model;

  const SubSaleItem({Key? key, required this.model}) : super(key: key);

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
                await SalesTab.fireSubDelete(context, model: model).then((bool value) => value == true ? ref.read(subSalesProvider.notifier).delete([model]) : null),
            backgroundColor: scheme.error,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (_) => SalesTab.fireSubForm(context, model.sale.value, model: model),
            backgroundColor: scheme.primary,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
        ],
      ),
      child: ListTile(
        trailing: model.breaks == 0
            ? null
            : Text(
                "- ${model.breaks}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
        subtitle: Text("${model.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: model.type.value == null
            ? null
            : ColorIndicator(
                width: 30,
                height: 30,
                borderRadius: 4,
                color: Color(model.type.value!.color),
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = Color(model.type.value!.color);
                  Color result = await showColorPickerDialog(context, colorBeforeDialog);
                  await ref.read(productionTypeModelProvider.notifier).update(
                    model.type.value!,
                    values: {"color": result.value},
                  );
                },
              ),
        title: Text("Lot: ${model.lot.value?.lotName(model.type.value) ?? "Lot no defined"}"),
        onLongPress: () {},
      ),
    );
  }
}
