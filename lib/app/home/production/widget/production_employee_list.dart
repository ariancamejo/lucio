import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/home/production/production_tab.dart';
import 'package:lucio/app/home/production/widget/work_prodction_item.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PrductionEmployeeList extends ConsumerWidget {
  final ProductionModel model;

  const PrductionEmployeeList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workProductions = ref.watch(workProductionProvider);
    final employees = ref.watch(employeeProvider);
    final filteredWorkProductions =
        workProductions.where((workProduction) => DateFormat(dateFormat).format(workProduction.datetime) == DateFormat(dateFormat).format(model.date)).toList();
    final employeesCopy = employees.toList();

    employeesCopy.removeWhere((emp) => filteredWorkProductions.where((element) => element.employee.value?.id == emp.id).isEmpty);

    return Scaffold(
      appBar: AppBar(
        title: Text("home.production.widgets.production_item.title".tr()),
      ),
      body: CustomScrollView(
        slivers: [
          MultiSliver(
              children: employeesCopy
                  .map(
                    (e) => Section(
                      titleIsBig: true,
                      title: Container(
                        color: Theme.of(context).cardColor,
                        child: ListTile(
                          title: Text(e.name ?? ""),
                        ),
                      ),
                      items: filteredWorkProductions
                          .where((element) => element.employee.value?.id == e.id)
                          .map(
                            (wp) => WorkProductionItem(model: wp, showProductionType: true),
                          )
                          .toList(),
                    ),
                  )
                  .toList())
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => ProductionTab.fireForm(context, initial: {"dateTimeParam": model.date}), child: const Icon(Icons.add)),
    );
  }
}
