import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/consume_materials/form/consumption_form.dart';
import 'package:lucio/app/screens/consume_materials/widgets/widgets/consume_material_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConsumeMaterialsPage extends ConsumerWidget {
  static String name = 'ConsumeMaterialsPage';

  const ConsumeMaterialsPage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {ConsumptionModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => ConsumptionForm(model: model),
      );

  static Future<bool> fireDelete(BuildContext context, {required ConsumptionModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove consumption of '${model.type.value?.name ?? ""}'"),
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
    final consumption = ref.watch(consumeMaterialsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material Consumption"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(consumeMaterialsProvider.notifier).findData(),
        child: consumption.isEmpty
            ? EmptyScreen(
                name: "Material Consumption",
                onTap: () => fireForm(context),
              )
            : ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(height: 1),
                itemBuilder: (_, index) => ConsumeMaterialItem(model: consumption[index]),
                itemCount: consumption.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
