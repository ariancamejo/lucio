import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';
import 'package:lucio/app/screens/type_of_sale/type_of_sale_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';

import 'package:lucio/data/repositories/type_of_sale/type_of_sale_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeOfSaleItem extends ConsumerWidget {
  final SaleTypeModel model;

  const TypeOfSaleItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final sales = ref.watch(saleProvider);
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
                await TypeOfSalePage.fireDelete(context, model: model).then((bool value) => value == true ? ref.read(saleTypeModelProvider.notifier).delete([model]) : null),
            backgroundColor: scheme.error,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (_) => TypeOfSalePage.fireForm(context, model: model),
            backgroundColor: scheme.primary,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(kDefaultRefNumber / 4),
          ),
          const SizedBox(width: 1),
        ],
      ),
      child: ListTile(
        title: Text(model.name),
        trailing: Text(sales.where((element) => element.saleType.value?.id == model.id).length.toString()),
        onLongPress: () => TypeOfSalePage.fireForm(context, model: model),
        onTap: () {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (_) => SalesTab(type: model));
        },
      ),
    );
  }
}
