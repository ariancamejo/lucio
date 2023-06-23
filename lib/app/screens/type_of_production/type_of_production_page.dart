import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/type_of_production/form/type_of_production_form.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/app/widgets/empty.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TypeOfProductionPage extends ConsumerWidget {
  static String name = 'TypeOfProductionPage';

  const TypeOfProductionPage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {ProductionTypeModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => TypeOfProductionForm(
          model: model,
        ),
      );

  static Future<bool> fireDelete(BuildContext context, {required ProductionTypeModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove type of production with name '${model.name}'"),
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
    final typeOfProductions = ref.watch(productionTypeModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Type of Productions"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(productionTypeModelProvider.notifier).findData(),
        child: typeOfProductions.isEmpty
            ? EmptyScreen(
                name: "Type of Production",
                onTap: () => fireForm(context),
              )
            : ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(height: 1),
                itemBuilder: (_, index) => TypeOfProductionItem(model: typeOfProductions[index]),
                itemCount: typeOfProductions.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
