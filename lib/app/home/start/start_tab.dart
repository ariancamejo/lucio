import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lucio/app/home/start/widgets/bar_chart.dart';
import 'package:lucio/app/home/start/widgets/line_chart.dart';
import 'package:lucio/app/home/start/widgets/pie_chart.dart';
import 'package:lucio/app/screens/employee/employee_page.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/data/repositories/consume_materials/consume_material_provider.dart';
import 'package:lucio/data/repositories/employe/employe_provider.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/type_of_production/type_of_production_provider.dart';
import 'package:lucio/data/repositories/units/units_provider.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';

class StartTab extends ConsumerWidget {
  const StartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeProductions = ref.watch(productionTypeModelProvider);
    final workProductions = ref.watch(workProductionProvider);
    final employees = ref.watch(employeeProvider);

    pie() => const StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Card(child: PieChartGraphic()),
        );
    leyend() => StaggeredGridTile.count(
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
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(e.name)),
                                    ColorIndicator(
                                      width: 20,
                                      height: 20,
                                      borderRadius: kDefaultRefNumber,
                                      color: Color(e.color),
                                      onSelectFocus: false,
                                      onSelect: () async {
                                        final Color colorBeforeDialog = Color(e.color);
                                        Color result = await showColorPickerDialog(context, colorBeforeDialog);
                                        await ref.read(productionTypeModelProvider.notifier).update(e, values: {"color": result.value});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ),
        );
    productionCount() => StaggeredGridTile.count(
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
        );
    employeesCount() => StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(kDefaultRefNumber),
              onTap: () {
                context.go(context.namedLocation(EmployeePage.name));
              },
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
        );
    bar({UnitOfMeasurementModel? unit}) => StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 4.2,
          child: Card(
            child: Center(
              child: BarChartGraphic(unit: unit),
            ),
          ),
        );

    line() => const StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 3.5,
          child: Card(
            child: Center(
              child: LineChartGraphic(),
            ),
          ),
        );
    final consum = ref.watch(consumeMaterialsProvider);
    final units = ref.watch(unitsProvider).units.where((element) => consum.map((cm) => cm.material.value?.unit.value?.id).toList().contains(element.id));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultRefNumber / 2),
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(workProductionProvider.notifier).findData();

            return Future.value();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              axisDirection: AxisDirection.down,
              children: [
                pie(),
                leyend(),
                productionCount(),
                employeesCount(),
                ...units.map((e) => bar(unit: e)).toList(),
                line(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
