import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';

class _LineChart extends ConsumerWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsales = ref.watch(subSalesProvider).where((element) => !(element.sale.value?.pendingSales ?? true)).toList();

    final productionTypes = ref.watch(productionTypeModelProvider);
    final scheme = Theme.of(context).colorScheme;
    List<LineChartBarData> chartData = productionTypes.map(
      (type) {
        final groupedSubSales = groupBy(subsales.where((element) {
          return (element.type.value?.id == type.id && element.sale.value != null);
        }), (subSale) => subSale.sale.value!.date.day);
        final List<FlSpot> flSpots = [];

        groupedSubSales.forEach((day, subsales) {
          final sum = subsales.fold<double>(0, (previousValue, subSale) => previousValue + subSale.quantity);

          flSpots.add(FlSpot(day.toDouble(), sum));
        });

        return LineChartBarData(
          isCurved: true,
          barWidth: 4,
          color: Color(type.color),
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: true),
          spots: flSpots,
        );
      },
    ).toList();

    FlTitlesData titlesData = const FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false), axisNameWidget: Text("")),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );

    return LineChart(
      LineChartData(
        gridData: gridData,
        borderData: FlBorderData(
          show: false,
          border: Border(
            bottom: BorderSide(color: scheme.primary, width: 1),
            left: const BorderSide(color: Colors.transparent),
            right: const BorderSide(color: Colors.transparent),
            top: const BorderSide(color: Colors.transparent),
          ),
        ),
        lineBarsData: chartData,
        titlesData: titlesData,
        minX: 1,
        minY: 0,
      ),
      duration: const Duration(milliseconds: 250),
    );
  }

  FlGridData get gridData => const FlGridData(show: true);
}

class LineChartGraphic extends StatefulWidget {
  const LineChartGraphic({super.key});

  @override
  State<StatefulWidget> createState() => LineChartGraphicState();
}

class LineChartGraphicState extends State<LineChartGraphic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultRefNumber),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sales",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PopupMenuButton<int>(
                initialValue: null,
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      break;
                  }
                },
                itemBuilder: (_) => const [PopupMenuItem(value: 1, child:  Text("View details"))],
              ),
            ],
          ),
        ),
        const Expanded(
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultRefNumber),
              child: _LineChart(),
            ),
          ),
        )
      ],
    );
  }
}
