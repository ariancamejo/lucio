import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/materials/form/materials_form.dart';
import 'package:lucio/app/screens/materials/widgets/material_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MaterialsPage extends ConsumerWidget {
  static String name = 'MaterialsPage';

  const MaterialsPage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {MaterialModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => MaterialForm(
          model: model,
        ),
      );

  static Future<bool> fireDelete(BuildContext context, {required MaterialModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove material with name '${model.name}'"),
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
    final materials = ref.watch(materialsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materials"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(materialsProvider.notifier).findData(),
        child: materials.isEmpty
            ? EmptyScreen(
                name: "Material",
                onTap: () => fireForm(context),
              )
            : ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(height: 1),
                itemBuilder: (_, index) => MaterialItem(model: materials[index]),
                itemCount: materials.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
