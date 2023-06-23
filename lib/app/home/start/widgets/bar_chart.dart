import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucio/app/home/start/widgets/pie_chart.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/materials/materials_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/data/repositories/units/units_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

class BarChartGraphic extends ConsumerStatefulWidget {
  const BarChartGraphic({super.key});

  @override
  ConsumerState<BarChartGraphic> createState() => _BarChartGraphicState();
}

class _BarChartGraphicState extends ConsumerState<BarChartGraphic> {
  int touchedGroupIndex = -1;
  bool show = false;
  bool refreshing = false;

  double roundToNextMultipleOf5(double number) {
    final double divided = number / 5.0;
    final int rounded = divided.ceil();
    return rounded * 5;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final units = ref.watch(unitsProvider);
    final materials = ref.watch(materialsProvider).where((element) => element.unit.value?.id == units.selected?.id).toList();
    final workProductions = ref.watch(workProductionProvider);
    final productTypes = ref.watch(productionTypeModelProvider);
    final consumption = ref.watch(consumeMaterialsProvider).where((element) => element.material.value?.unit.value?.id == units.selected?.id).toList();

    return Padding(
      padding: const EdgeInsets.all(kDefaultRefNumber),
      child: LayoutBuilder(builder: (context, contrain) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Builder(builder: (context) {
                      List<_BarData> dataList = [];
                      double maxValue = 100;
                      if (consumption.isNotEmpty && productTypes.isNotEmpty && workProductions.isNotEmpty) {
                        dataList = productTypes
                            .map((type) => _BarData(
                                Color(type.color),
                                consumption
                                    .where((f) => f.type.value?.id == type.id)
                                    .map((co) => DataWithColor(
                                        material: co.material.value, value: co.quantity(PieChartGraphic.quantityOfProductionType(workProductions, type, productTypes).toInt())))
                                    .toList()))
                            .toList();
                        maxValue = dataList
                            .map((myObject) =>
                                myObject.consumptions.fold<double>(double.negativeInfinity, (currentMax, listMax) => listMax.value > currentMax ? listMax.value : currentMax))
                            .fold<double>(double.negativeInfinity, (a, b) => a > b ? a : b);
                      }
                      maxValue = roundToNextMultipleOf5(maxValue);
                      final scheme = Theme.of(context).colorScheme;

                      return BarChart(
                        key: Key(refreshing.toString()),
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          borderData: FlBorderData(
                            show: true,
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: scheme.onBackground.withOpacity(0.2),
                              ),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              drawBelowEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    textAlign: TextAlign.left,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 36,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: _IconWidget(
                                      color: dataList[index].color,
                                      isSelected: touchedGroupIndex == index,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(),
                            topTitles: const AxisTitles(),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: scheme.onBackground.withOpacity(0.2),
                              strokeWidth: 1,
                            ),
                          ),
                          barGroups: dataList.asMap().entries.map((e) {
                            final index = e.key;
                            final data = e.value;
                            return BarChartGroupData(
                              x: index,
                              barRods: data.consumptions
                                  .map(
                                    (e) => BarChartRodData(
                                      toY: e.value,
                                      color: Color(e.material?.color ?? 0x00000000),
                                      width: 6,
                                    ),
                                  )
                                  .toList(),
                              showingTooltipIndicators: touchedGroupIndex == index ? [0] : [],
                            );
                          }).toList(),
                          maxY: maxValue,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipMargin: 0,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                return BarTooltipItem(
                                  "",
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: rod.color,
                                    fontSize: 18,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black26,
                                        blurRadius: 12,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            touchCallback: (event, response) {
                              if (event.isInterestedForInteractions && response != null && response.spot != null) {
                                setState(() {
                                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                                });
                              } else {
                                setState(() {
                                  touchedGroupIndex = -1;
                                });
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: contrain.maxHeight / 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<UnitOfMeasurementModel>(
                      initialValue: units.selected,
                      onSelected: (value) {
                        ref.read(unitsProvider.notifier).selected = value;
                      },
                      itemBuilder: (_) => units.units.map((e) => PopupMenuItem(value: e, child: Text(e.value))).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: Text("Materials (${units.selected?.key ?? ""})", textAlign: TextAlign.left)),
                  const SizedBox(width: double.maxFinite, height: kDefaultRefNumber / 2),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0, // espacio horizontal entre los chips
                        runSpacing: 4.0, // espacio vertical entre las filas de chips
                        children: materials
                            .map(
                              (e) => Chip(
                                surfaceTintColor: Color(e.color),
                                avatar: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(kDefaultRefNumber / 4), color: Color(e.color)),
                                ),
                                label: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

class DataWithColor {
  final MaterialModel? material;
  final double value;

  DataWithColor({this.material, required this.value});
}

class _BarData {
  const _BarData(this.color, this.consumptions);

  final Color color;
  final List<DataWithColor> consumptions;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;

    return CircleAvatar(radius: 10, backgroundColor: widget.color);
    // return Transform(
    //   transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
    //   origin: const Offset(14, 14),
    //
    //   child: Icon(
    //     widget.isSelected ?FontAwesomeIcons.industry : FontAwesomeIcons.industry,
    //     color: widget.color,
    //     size: 28,
    //   ),
    // );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
