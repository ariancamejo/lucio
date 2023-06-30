import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/app/home/production/widget/work_prodction_item.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:collection/collection.dart';

class ProductionItem extends ConsumerStatefulWidget {
  final ProductionModel model;
  final bool showChildren;

  const ProductionItem({Key? key, required this.model, this.showChildren = false}) : super(key: key);

  @override
  ConsumerState<ProductionItem> createState() => _ProductionItemState();
}

class _ProductionItemState extends ConsumerState<ProductionItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                DateFormat(dateFormat).format(widget.model.date),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showCupertinoModalBottomSheet(context: context, builder: (_) => _WorkProduction(model: widget.model));
                    },
                    icon: const Icon(Icons.production_quantity_limits),
                  ),
                ],
              ),
            ),
            FadeIn(child: _InfoProduction(model: widget.model))
          ],
        ),
      ),
    );
  }
}

class _WorkProduction extends ConsumerWidget {
  final ProductionModel model;

  const _WorkProduction({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workProductions = ref.watch(workProductionProvider);
    final employees = ref.watch(employeeProvider);
    final filteredWorkProductions =
        workProductions.where((workProduction) => DateFormat(dateFormat).format(workProduction.datetime) == DateFormat(dateFormat).format(model.date)).toList();

    // Agrupar la lista de trabajo por empleados
    final employeeWorkProductions = groupBy(filteredWorkProductions, (workProduction) => workProduction.employee.value?.id);

    // Crear una lista de tabs y vistas
    final tabs = employeeWorkProductions.keys
        .map((employeeID) => Tab(
              key: Key(employeeID.toString()),
              text: employees.firstWhere((element) => element.id == employeeID).name,
            ))
        .toList();

    final views = employeeWorkProductions.entries.map((entry) {
      final productionItems = entry.value
          .map(
            (workProduction) => WorkProductionItem(model: workProduction, showProductionType: true),
          )
          .toList();
      return ListView(
        children: productionItems,
      );
    }).toList();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("home.production.widgets.production_item.title".tr()),
          bottom: TabBar(
            isScrollable: true,
            physics: const BouncingScrollPhysics(),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: views,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ProductionTab.fireForm(context, initial: {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _InfoProduction extends ConsumerWidget {
  final ProductionModel model;

  const _InfoProduction({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workPs = ref.watch(workProductionProvider);
    final decimals = ref.watch(optionsP).decimals;
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: model.types(),
        builder: (context, typess) {
          return SingleChildScrollView(
            child: Column(
              children: (typess.data ?? [])
                  .map(
                    (e) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TypeOfProductionItem(
                            model: e,
                            item: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("home.production.widgets.production_item.real".tr()),
                                    Text(
                                      ' (${model.breaksPercent(productions: workPs.where((element) => element.type.value?.id == e.id).toList(), breaks: false).toStringAsFixed(decimals)}%)',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    FutureBuilder(
                                      future: model.details(e, typeResult: ProductionTypeResult.real),
                                      builder: (_, snap) => Text(
                                        snap.data?.toStringAsFixed(decimals) ?? "",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: kDefaultRefNumber),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("home.production.widgets.production_item.breaks".tr()),
                                    Text(
                                      ' (${model.breaksPercent(productions: workPs.where((element) => element.type.value?.id == e.id).toList(), breaks: true).toStringAsFixed(decimals)}%)',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    FutureBuilder(
                                      future: model.details(e, typeResult: ProductionTypeResult.breaks),
                                      builder: (_, snap) {
                                        return Text(
                                          snap.data?.toStringAsFixed(decimals) ?? "",
                                          style: const TextStyle(fontSize: 18),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2),
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
                              TableRow(children: [
                                FutureBuilder(
                                  future: model.details(e, typeResult: ProductionTypeResult.all),
                                  builder: (_, snap) => Text(
                                    snap.data?.toStringAsFixed(decimals) ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FutureBuilder(
                                  future: model.details(e, typeResult: ProductionTypeResult.process),
                                  builder: (_, snap) => Text(
                                    snap.data?.toStringAsFixed(decimals) ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FutureBuilder(
                                  future: model.details(e, typeResult: ProductionTypeResult.available),
                                  builder: (_, snap) => Text(
                                    snap.data?.toStringAsFixed(decimals) ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FutureBuilder(
                                  future: model.details(e, typeResult: ProductionTypeResult.sold),
                                  builder: (_, snap) => Text(
                                    snap.data?.toStringAsFixed(decimals) ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultRefNumber,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
