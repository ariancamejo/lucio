import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucio/app/screens/type_of_sale/form/type_of_sale_form.dart';
import 'package:lucio/app/screens/type_of_sale/widgets/type_of_sale_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_sale/type_of_sale_provider.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeOfSalePage extends ConsumerWidget {
  static String name = 'TypeOfSalePage';

  const TypeOfSalePage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {SaleTypeModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => TypeOfSaleForm(
          model: model,
        ),
      );

  static Future<bool> fireDelete(BuildContext context, {required SaleTypeModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove type of sale with name '${model.name}'"),
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
    final typeOfSales = ref.watch(saleTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Type of Sales"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(saleTypeModelProvider.notifier).findData(),
        child: typeOfSales.isEmpty
            ? EmptyScreen(
                name: "Type of Sale",
                onTap: () => fireForm(context),
              )
            : ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(height: 1),
                itemBuilder: (_, index) {
                  if (index == typeOfSales.length) {
                    return const SizedBox(height: 60);
                  }

                  return TypeOfSaleItem(model: typeOfSales[index]);
                },
                itemCount: typeOfSales.length + 1,
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
