import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/form/work_production_form.dart';
import 'package:lucio/app/home/production/widget/production_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductionTab extends ConsumerWidget {
  const ProductionTab({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {WorkProductionModel? model}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => WorkProductionForm(
          model: model,
        ),
      );

  static Future<bool> fireDelete(BuildContext context, {required WorkProductionModel model}) async {
    bool? res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Can you sure ?"),
        content: Text("Press 'Delete' for remove work production of '${model.employee.value?.name ?? ""}' on ${DateFormat(dateFormat).format(model.datetime)}"),
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
    final productions = ref.watch(productionProvider);
    return Scaffold(
      body: productions.isEmpty
          ?  EmptyScreen(
              name: "Work Production",
              onTap: () => fireForm(context),
            )
          : RefreshIndicator(
              onRefresh: () async => ref.read(productionProvider.notifier).findData(),
              child: CustomScrollView(
                slivers: [
                  MultiSliver(
                    pushPinnedChildren: true,
                    children: productions.map((e) => ProductionItem(model: e)).toList(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 60))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.small(onPressed: () => fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
