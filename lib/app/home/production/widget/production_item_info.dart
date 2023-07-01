import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/screens/type_of_production/widgets/type_of_production_item.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ProductionByTypeInfo extends ConsumerWidget {
  final ProductionModel model;

  const ProductionByTypeInfo({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workPs = ref.watch(workProductionProvider);
    final subSalesPs = ref.watch(subSalesProvider);
    final decimals = ref.watch(optionsP).decimals;
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: model.types(),
        builder: (context, typess) {
          if (typess.connectionState != ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultRefNumber),
                child: const LinearProgressIndicator(),
              ),
            );
          }

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
                                      '(${model.breaksPercent(productions: workPs.where((element) => element.type.value?.id == e.id).toList(), breaks: false).toStringAsFixed(decimals)}%)',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.real).toStringAsFixed(decimals),
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
                                      '(${model.breaksPercent(productions: workPs.where((element) => element.type.value?.id == e.id).toList(), breaks: true).toStringAsFixed(decimals)}%)',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.breaks).toStringAsFixed(decimals),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18),
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
                                Text(model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.all).toStringAsFixed(decimals), textAlign: TextAlign.center),
                                Text(model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.process).toStringAsFixed(decimals), textAlign: TextAlign.center),
                                Text(model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.available).toStringAsFixed(decimals), textAlign: TextAlign.center),
                                Text(model.detailsNoSync(workPs, subSalesPs, e, typeResult: ProductionTypeResult.sold).toStringAsFixed(decimals), textAlign: TextAlign.center),
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
