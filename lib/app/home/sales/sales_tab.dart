import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/form/sale_form.dart';

import 'package:lucio/app/home/sales/form/subsale_form.dart';
import 'package:lucio/app/home/sales/widgets/sale_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SalesTab extends ConsumerWidget {
  const SalesTab({Key? key}) : super(key: key);

  static fireSubForm(BuildContext context, SaleModel? sale, {SubSaleModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => SubSaleForm(
          model: model,
          saleModel: sale,
        ),
      );

  static fireForm(BuildContext context, {SaleModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => SaleForm(model: model),
      );

  static Future<bool> fireSubDelete(BuildContext context, {required SubSaleModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text(
            "Press 'Delete' for remove sale for '${model.sale.value?.client ?? ""}' on ${model.sale.value == null ? "--" : DateFormat(dateFormat).format(model.sale.value!.date)}"),
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
    final sales = ref.watch(saleProvider);
    return Scaffold(
      body: sales.isEmpty
          ? EmptyScreen(
              name: "Sale",
              onTap: () => fireForm(context),
            )
          : RefreshIndicator(
              onRefresh: () async => ref.read(saleProvider.notifier).findData(),
              child: CustomScrollView(
                slivers: [
                  MultiSliver(
                    pushPinnedChildren: true,
                    children: sales.map((e) => SaleItem(model: e)).toList(),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.small(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
