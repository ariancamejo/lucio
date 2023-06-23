import 'package:isar/isar.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'employe_model.g.dart';

@collection
class EmployeModel {
  Id id = Isar.autoIncrement;
  late String name;
  late String ci;
  late int plan;

  @Backlink(to: 'employee')
  final workProductions = IsarLinks<WorkProductionModel>();
}
