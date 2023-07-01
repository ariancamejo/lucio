import 'package:isar/isar.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'employe_model.g.dart';

@collection
class EmployeModel {
  Id id = Isar.autoIncrement;
  late String name;
  String? ci;

  @Backlink(to: 'employee')
  final plans = IsarLinks<EmployeePlanModel>();

  @Backlink(to: 'employee')
  final workProductions = IsarLinks<WorkProductionModel>();

  Future<double> real(
    ProductionTypeModel type, {
    required DateTime startFilter,
    required DateTime endFilter,
  }) async {
    double real =
        (await DBHelper.isar.workProductionModels.filter().type((q) => q.idEqualTo(type.id)).datetimeBetween(startFilter, endFilter).employee((q) => q.idEqualTo(id)).findAll())
            .fold(0, (sum, item) => sum + item.quantity - item.breaks);
    return real;
  }
}

@collection
class EmployeePlanModel {
  Id id = Isar.autoIncrement;
  IsarLink<EmployeModel> employee = IsarLink<EmployeModel>();
  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();
  double plan = 0;
}
