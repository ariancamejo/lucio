import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucio/app/home/production/widget/work_prodction_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class ProductionItem extends ConsumerWidget {
  final ProductionModel model;

  const ProductionItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workProductions = ref.watch(workProductionProvider);

    final filteredWorkProductions = workProductions.where((workProduction) => DateFormat(dateFormat).format(workProduction.datetime) == DateFormat(dateFormat).format(model.date));
    final workProductionItems = filteredWorkProductions.map((workProduction) => WorkProductionItem(model: workProduction)).toList();

    return Section(
      title: Text(
        DateFormat(dateFormat).format(model.date),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      boxDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      items: workProductionItems,
    );
  }
}
