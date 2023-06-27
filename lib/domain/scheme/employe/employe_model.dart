import 'package:isar/isar.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'employe_model.g.dart';

@collection
class EmployeModel {
  Id id = Isar.autoIncrement;
  late String name;
  String? ci;
  late double plan;

  @Backlink(to: 'employee')
  final workProductions = IsarLinks<WorkProductionModel>();

  Future<double> real({required DateTime startFilter, required DateTime endFilter}) async {
    double real = (await DBHelper.isar.workProductionModels.filter().datetimeBetween(startFilter, endFilter).employee((q) => q.idEqualTo(id)).findAll())
        .fold(0, (sum, item) => sum + item.quantity);
    return real;
  }
}
