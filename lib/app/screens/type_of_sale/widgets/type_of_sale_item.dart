import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucio/app/screens/type_of_sale/type_of_sale_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_sale/type_of_sale_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

class TypeOfSaleItem extends ConsumerWidget {
  final SaleTypeModel model;

  const TypeOfSaleItem({Key? key, required this.model}) : super(key: key);

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
        onLongPress: () => TypeOfSalePage.fireForm(context, model: model),
      ),
    );
  }
}
