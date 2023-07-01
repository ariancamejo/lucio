import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucio/app/screens/consume_materials/form/consumption_form.dart';
import 'package:lucio/app/screens/consume_materials/widgets/widgets/consume_material_item.dart';

import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ConsumeMaterialsPage extends ConsumerWidget {
  static String name = 'ConsumeMaterialsPage';

  const ConsumeMaterialsPage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {ConsumptionModel? model, Map<String, dynamic>? initial }) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => ConsumptionForm(model: model,initial:initial),
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
    final typeOfProductions = ref.watch(productionTypeModelProvider);
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
            : CustomScrollView(
                slivers: [
                  MultiSliver(
                    children: typeOfProductions
                        .map(
                          (e) => Section(
                            titleIsBig: true,
                            title: Container(
                              color: Theme.of(context).cardColor,
                              child: ListTile(
                                title: Text(e.name, style: TextStyle(color: Color(e.color)),),
                                trailing: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:Color(e.color)
                                  ),
                                ),
                              ),
                            ),
                            items: consumption
                                .where((element) => element.type.value?.id == e.id)
                                .map(
                                  (p) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ConsumeMaterialItem(model: p, typeShow: false),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 60))
                ],
              ),

        //
        // ListView.separated(
        //         separatorBuilder: (_, index) => const SizedBox(height: 1),
        //         itemBuilder: (_, index) {
        //           if (index == consumption.length) {
        //             return const SizedBox(height: 60);
        //           }
        //
        //           return ConsumeMaterialItem(model: consumption[index]);
        //         },
        //         itemCount: consumption.length + 1,
        //       ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
