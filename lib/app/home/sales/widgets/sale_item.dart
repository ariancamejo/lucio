import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';
import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';

import 'package:lucio/domain/scheme/sale/sale_model.dart';

class SaleItem extends ConsumerWidget {
  final SaleModel model;

  const SaleItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subSales = ref.watch(subSalesProvider);

    final filteredSales = subSales.where((sale) => sale.sale.value?.id == model.id);
    final salesItems = filteredSales.map((saleItem) => SubSaleItem(model: saleItem)).toList();

    return Section(
      title: Text(
        model.client,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      subtitle: Text(
        DateFormat("$dateFormat hh:mm a").format(model.date),
      ),
      action: Padding(
        padding: const EdgeInsets.only(right: kDefaultRefNumber),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [TextButton(onPressed: () => SalesTab.fireSubForm(context, model), child: const Text("Add new Sub Sale"))],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => SalesTab.fireForm(context, model: model),
            icon: const Icon(FontAwesomeIcons.pencil),
          ),
          salesItems.isEmpty
              ? IconButton(
                  onPressed: () {
                    ref.read(saleProvider.notifier).delete([model]);
                  },
                  icon: const Icon(FontAwesomeIcons.trash),
                )
              : Checkbox(
                  value: model.deposit,
                  onChanged: (value) {
                    ref.read(saleProvider.notifier).update(model, values: {"deposit": value});
                  },
                )
        ],
      ),
      boxDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      items: salesItems,
    );
  }
}
