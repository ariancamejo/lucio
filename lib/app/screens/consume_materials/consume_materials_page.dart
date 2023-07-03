import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/home/start/widgets/pie_chart.dart';

import 'package:lucio/app/screens/consume_materials/form/consumption_form.dart';
import 'package:lucio/app/screens/consume_materials/widgets/widgets/consume_material_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ConsumeMaterialsPage extends ConsumerStatefulWidget {
  static String name = 'ConsumeMaterialsPage';

  const ConsumeMaterialsPage({Key? key}) : super(key: key);

  static fireForm(BuildContext context, {ConsumptionModel? model, Map<String, dynamic>? initial}) => showCupertinoModalBottomSheet(
        context: context,
        builder: (_) => ConsumptionForm(model: model, initial: initial),
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
  ConsumerState<ConsumeMaterialsPage> createState() => _ConsumeMaterialsPageState();
}

class _ConsumeMaterialsPageState extends ConsumerState<ConsumeMaterialsPage> {
  DateTime? now;

  @override
  Widget build(BuildContext context) {
    final typeOfProductions = ref.watch(productionTypeModelProvider);
    final consumption = ref.watch(consumeMaterialsProvider);
    List<WorkProductionModel> workProductions = ref.watch(workProductionProvider);
    final options = ref.watch(optionsP);
    if (now != null) {
      DateTime startDate = DateTime(now!.year, now!.month, now!.day, 0, 0, 0);
      DateTime endDate = DateTime(now!.year, now!.month, now!.day, 23, 59, 59);
      workProductions = workProductions.where((element) => element.datetime.isAfter(startDate) && element.datetime.isBefore(endDate)).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Material Consumption"),
        actions: [
          IconButton(
            onPressed: () async {
              if (now == null) {
                DateTime tempNow = DateTime.now();
                now = await showDatePicker(
                  context: context,
                  initialDate: tempNow.isBefore(options.endFilter) ? tempNow : options.endFilter,
                  firstDate: options.startFilter,
                  lastDate: options.endFilter,
                );
              } else {
                now = null;
              }
              setState(() {});
            },
            icon: Icon(now == null ? Icons.date_range : Icons.today),
          ),
          const SizedBox(width: kDefaultRefNumber)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.read(consumeMaterialsProvider.notifier).findData(),
        child: consumption.isEmpty
            ? EmptyScreen(
                name: "Material Consumption",
                onTap: () => ConsumeMaterialsPage.fireForm(context),
              )
            : CustomScrollView(
                slivers: [
                  SliverPinnedHeader(
                    child: Container(
                      padding: const EdgeInsets.all(kDefaultRefNumber / 2),
                      color: Theme.of(context).cardColor,
                      child: now == null
                          ? Text(
                              "${DateFormat(dateFormat).format(options.startFilter)} ---- ${DateFormat(dateFormat).format(options.endFilter)}",
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              DateFormat(dateFormat).format(now!),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  MultiSliver(
                    children: typeOfProductions
                        .map(
                          (e) => Section(
                            titleIsBig: true,
                            title: Container(
                              color: Theme.of(context).cardColor,
                              child: ListTile(
                                title: Text(
                                  e.name,
                                  style: TextStyle(color: Color(e.color)),
                                ),
                                trailing: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(e.color)),
                                ),
                              ),
                            ),
                            items: consumption
                                .where((element) => element.type.value?.id == e.id)
                                .map(
                                  (p) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ConsumeMaterialItem(
                                      model: p,
                                      subtitle: Text("${p.quantity(
                                            PieChartGraphic.quantityOfProductionType(workProductions, e),
                                          ).toStringAsFixed(options.decimals)} (${p.material.value?.unit.value?.key ?? ""})"),
                                    ),
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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => ConsumeMaterialsPage.fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
