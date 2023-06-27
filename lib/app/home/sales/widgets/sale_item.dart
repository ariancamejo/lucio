import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/sales/sales_tab.dart';
import 'package:lucio/app/home/sales/widgets/sub_sale_item.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sales_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:collection/collection.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/device/helpers/biometric/fingerprint.dart';

import 'package:lucio/domain/scheme/sale/sale_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SaleItem extends ConsumerStatefulWidget {
  final SaleModel model;

  const SaleItem({Key? key, required this.model}) : super(key: key);

  @override
  ConsumerState<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends ConsumerState<SaleItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            widget.model.client,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          subtitle: Text(
            DateFormat("$dateFormat hh:mm a").format(widget.model.date),
          ),
          leading: Checkbox(
            value: widget.model.deposit,
            visualDensity: VisualDensity.compact,
            onChanged: (value) {
              checkAuth(ref, message: "${value == true ? "Check" : "Uncheck"} Deposit of sale", onSuccess: () {
                ref.read(saleProvider.notifier).update(widget.model, values: {"deposit": value});
              });
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => SalesTab.fireForm(context, model: widget.model),
                icon: const Icon(FontAwesomeIcons.pencil),
              ),
              IconButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(context: context, builder: (_) => _SubSale(model: widget.model));
                },
                icon: const Icon(Icons.shopify),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => SalesTab.fireSubForm(context, widget.model),
            child: const Text("Add new Sub Sale"),
          ),
        ),
        FadeIn(child: _InfoSale(model: widget.model))
      ],
    );
  }
}

class _InfoSale extends StatelessWidget {
  final SaleModel model;

  const _InfoSale({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: model.types(),
        builder: (context, typess) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
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
                                      const Text("Quantity"),
                                      FutureBuilder(
                                        future: model.saled(e, typeResult: SaleTypeResult.quantity),
                                        builder: (_, snap) => Text(
                                          "${snap.data ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: kDefaultRefNumber),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Breaks"),
                                      FutureBuilder(
                                        future: model.saled(e, typeResult: SaleTypeResult.breaks),
                                        builder: (_, snap) => Text(
                                          "${snap.data ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Table(
                              columnWidths: {
                                0: FixedColumnWidth(size.width * 0.31),
                                1: FixedColumnWidth(size.width * 0.31),
                                3: FixedColumnWidth(size.width * 0.31),
                              },
                              children: [
                                const TableRow(children: [
                                  Text("Total", textAlign: TextAlign.center),
                                  Text("With Lot", textAlign: TextAlign.center),
                                  Text("WitOut Lot", textAlign: TextAlign.center),
                                ]),
                                TableRow(children: [
                                  FutureBuilder(
                                    future: model.saled(e, typeResult: SaleTypeResult.all),
                                    builder: (_, snap) => Text("${snap.data ?? ""}", textAlign: TextAlign.center),
                                  ),
                                  FutureBuilder(
                                    future: model.saled(e, typeResult: SaleTypeResult.withlot),
                                    builder: (_, snap) => Text("${snap.data ?? ""}", textAlign: TextAlign.center),
                                  ),
                                  FutureBuilder(
                                    future: model.saled(e, typeResult: SaleTypeResult.withoutlot),
                                    builder: (_, snap) => Text("${snap.data ?? ""}", textAlign: TextAlign.center),
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
            ),
          );
        });
  }
}

class _SubSale extends ConsumerWidget {
  final SaleModel model;

  const _SubSale({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subSales = ref.watch(subSalesProvider);
    final typeProductions = ref.watch(productionTypeModelProvider);
    final filteredSales = subSales.where((sale) => sale.sale.value?.id == model.id);

    final subSalesGrouped = groupBy(filteredSales, (ss) => ss.type.value?.id);

    // Crear una lista de tabs y vistas
    final tabs = subSalesGrouped.keys
        .map((ssId) => Tab(
              key: Key(ssId.toString()),
              text: typeProductions.firstWhere((element) => element.id == ssId).name,
            ))
        .toList();

    final salesItems = filteredSales.map((saleItem) => SubSaleItem(model: saleItem)).toList();

    // Agrupar la lista de trabajo por empleados

    final views = subSalesGrouped.entries.map((entry) {
      final productionItems = entry.value
          .map(
            (workProduction) => SubSaleItem(model: workProduction),
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
          title: const Text("Sub Sales"),
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: views,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SalesTab.fireSubForm(context, model);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
