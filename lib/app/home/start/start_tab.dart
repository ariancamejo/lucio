import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucio/app/home/start/widgets/bar_chart.dart';
import 'package:lucio/app/home/start/widgets/pie_chart.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';

class StartTab extends ConsumerWidget {
  const StartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeProductions = ref.watch(productionTypeModelProvider);
    final workProductions = ref.watch(workProductionProvider);
    final employees = ref.watch(employeeProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          axisDirection: AxisDirection.down,
          children: [
            const StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Production",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    PieChartGraphic()
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultRefNumber / 2),
                  child: typeProductions.isEmpty
                      ? LayoutBuilder(
                          builder: (_, contrain) => const Center(
                            child: Icon(FontAwesomeIcons.industry),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: typeProductions
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(children: [CircleAvatar(radius: 5, backgroundColor: Color(e.color)), const SizedBox(width: 4), Expanded(child: Text(e.name))]),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Center(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [const Icon(Icons.production_quantity_limits), const SizedBox(height: 4, width: double.maxFinite), Text(workProductions.length.toString())],
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Center(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.helmetSafety),
                      const SizedBox(height: 4, width: double.maxFinite),
                      Text("${employees.length}"),
                    ],
                  ),
                ),
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 5,
              child: Card(
                child: Center(
                  child: BarChartGraphic(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
