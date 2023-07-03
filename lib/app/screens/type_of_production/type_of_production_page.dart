import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/type_of_production/form/type_of_production_form.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/app/widgets/empty.dart';
import 'package:lucio/app/widgets/section_widget.dart';

import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TypeOfProductionPage extends ConsumerStatefulWidget {
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
  ConsumerState<TypeOfProductionPage> createState() => _TypeOfProductionPageState();
}

class _TypeOfProductionPageState extends ConsumerState<TypeOfProductionPage> {
  DateTime? now;

  @override
  Widget build(BuildContext context) {
    final typeOfProductions = ref.watch(productionTypeModelProvider);
    List<SubSaleModel> subSales = ref.watch(subSalesProvider);
    final size = MediaQuery.of(context).size;
    final options = ref.watch(optionsP);
    List<WorkProductionModel> workProductions = ref.watch(workProductionProvider);

    if (now != null) {
      DateTime startDate = DateTime(now!.year, now!.month, now!.day, 0, 0, 0);
      DateTime endDate = DateTime(now!.year, now!.month, now!.day, 23, 59, 59);
      workProductions = workProductions.where((element) => element.datetime.isAfter(startDate) && element.datetime.isBefore(endDate)).toList();
      subSales = subSales.where((element) => element.sale.value != null && element.sale.value!.date.isAfter(startDate) && element.sale.value!.date.isBefore(endDate)).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Type of Productions"),
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
        onRefresh: () async => await ref.read(productionTypeModelProvider.notifier).findData(),
        child: typeOfProductions.isEmpty
            ? EmptyScreen(
                name: "Type of Production",
                onTap: () => TypeOfProductionPage.fireForm(context),
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
                            divider: true,
                            title: Container(
                              color: Theme.of(context).cardColor,
                              child: TypeOfProductionItem(
                                model: e,
                                showColors: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("home.production.widgets.production_item.real".tr()),
                                        Text(
                                          '(${ProductionModel().breaksPercent(productions: workProductions.where((element) => element.type.value?.id == e.id).toList(), breaks: false, withOutP: true).toStringAsFixed(options.decimals)}%)',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.real, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: kDefaultRefNumber),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("home.production.widgets.production_item.breaks".tr()),
                                        Text(
                                          '(${ProductionModel().breaksPercent(productions: workProductions.where((element) => element.type.value?.id == e.id).toList(), breaks: true, withOutP: true).toStringAsFixed(options.decimals)}%)',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.breaks, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            items: [
                              Table(
                                columnWidths: {
                                  0: FixedColumnWidth(size.width * 0.22),
                                  1: FixedColumnWidth(size.width * 0.22),
                                  2: FixedColumnWidth(size.width * 0.22),
                                  3: FixedColumnWidth(size.width * 0.22),
                                },
                                children: [
                                  TableRow(children: [
                                    Text("home.production.widgets.production_item.status.total".tr(), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                    Text("home.production.widgets.production_item.status.in_progress".tr(), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                    Text("home.production.widgets.production_item.status.available".tr(), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                    Text("home.production.widgets.production_item.status.sold".tr(), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  ]),
                                  TableRow(
                                    children: [
                                      Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.all, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center),
                                      Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.process, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center),
                                      Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.available, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center),
                                      Text(
                                          ProductionModel()
                                              .detailsNoSync(workProductions, subSales, e, typeResult: ProductionTypeResult.sold, withOutP: true)
                                              .toStringAsFixed(options.decimals),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 60))
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => TypeOfProductionPage.fireForm(context), child: const Icon(Icons.add)),
    );
  }
}
