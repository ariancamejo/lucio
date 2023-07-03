import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/home/start/widgets/pie_chart.dart';
import 'package:lucio/app/screens/consume_materials/consume_materials_page.dart';
import 'package:lucio/app/widgets/section_widget.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/data/repositories/options_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:sliver_tools/sliver_tools.dart';

class BarChartDetail extends ConsumerStatefulWidget {
  const BarChartDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<BarChartDetail> createState() => _BarChartDetailState();
}

class _BarChartDetailState extends ConsumerState<BarChartDetail> {
  DateTime? now;

  @override
  Widget build(BuildContext context) {
    final productionTypes = ref.watch(productionTypeModelProvider);
    final materials = ref.watch(materialsProvider);
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
        title: Text(
          now == null ? "${DateFormat(dateFormat).format(options.startFilter)} ---- ${DateFormat(dateFormat).format(options.endFilter)}" : DateFormat(dateFormat).format(now!),
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (now == null) {
                now = DateTime.now();
              } else {
                now = null;
              }
              setState(() {});
            },
            icon: const Icon(Icons.change_circle_outlined),
          ),
          const SizedBox(width: kDefaultRefNumber)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          MultiSliver(
            children: productionTypes
                .map(
                  (type) => Section(
                    titleIsBig: true,
                    divider: true,
                    title: Container(
                      color: Theme.of(context).cardColor,
                      child: ListTile(
                        title: Text(
                          type.name,
                          style: TextStyle(
                            color: Color(type.color),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(FontAwesomeIcons.recycle),
                          onPressed: () {
                            ConsumeMaterialsPage.fireForm(context, initial: {"type": type});
                          },
                        ),
                      ),
                    ),
                    items: materials.where((element) => consumption.where((cons) => cons.material.value?.id == element.id && cons.type.value?.id == type.id).length == 1).map(
                      (m) {
                        ConsumptionModel consump = consumption.firstWhere((cons) => cons.material.value?.id == m.id && cons.type.value?.id == type.id);

                        return ListTile(
                          onLongPress: () {
                            ConsumeMaterialsPage.fireForm(context, model: consump);
                          },
                          title: Text(m.name),
                          subtitle: Text("${consump.quantity(
                                PieChartGraphic.quantityOfProductionType(workProductions, type),
                              ).toStringAsFixed(options.decimals)} (${m.unit.value?.key ?? ""})"),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(m.unit.value?.value ?? ""),
                              Text(
                                "${consump.quantityMaterial} / ${consump.quantityType} ",
                              )
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
