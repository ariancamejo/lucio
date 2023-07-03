import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

class PieChartGraphic extends ConsumerStatefulWidget {
  const PieChartGraphic({Key? key}) : super(key: key);

  static double _allCount(List<WorkProductionModel> wp) {
    double total = 0.0;
    for (var element in wp) {
      total = total + (element.quantity);
      // total = total + (element.quantity - element.breaks);
    }
    return total;
  }

  static double quantityOfProductionType(List<WorkProductionModel> all, ProductionTypeModel p) {
    double total = 0.0;

    total = _allCount(all);
    List<WorkProductionModel> workProductionPerType = all.where((element) => element.type.value?.id == p.id).toList();
    if (total == 0 || workProductionPerType.isEmpty) {
      return 0.0;
    }

    return _allCount(workProductionPerType);
  }

  @override
  ConsumerState<PieChartGraphic> createState() => _PieChartGraphicState();
}

class _PieChartGraphicState extends ConsumerState<PieChartGraphic> {
  @override
  Widget build(BuildContext context) {
    final workP = ref.watch(workProductionProvider);
    final prodyctionType = ref.watch(productionTypeModelProvider);
    return LayoutBuilder(
      builder: (_, contrain) => AspectRatio(
        aspectRatio: 1.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Production",
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: prodyctionType.isEmpty || workP.isEmpty
                  ? Center(
                      child: Icon(FontAwesomeIcons.industry, size: contrain.maxWidth / 2),
                    )
                  : PieChart(
                      PieChartData(
                        sections: prodyctionType
                            .map(
                              (e) => PieChartSectionData(
                                showTitle: false,
                                value: PieChartGraphic.quantityOfProductionType(workP, e),
                                color: Color(e.color).withOpacity(0.8),
                                title: PieChartGraphic.quantityOfProductionType(workP, e).toStringAsFixed(0),
                                radius: contrain.maxWidth / 4,
                                titleStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                            .toList(),
                        borderData: FlBorderData(show: true),
                        sectionsSpace: 0,
                        centerSpaceRadius: 5,
                        centerSpaceColor: Theme.of(context).cardColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
