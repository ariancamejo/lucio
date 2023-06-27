import 'package:isar/isar.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static late Isar isar;

  static List<CollectionSchema> schemes = [
    EmployeModelSchema,
    EmployeePlanModelSchema,
    ProductionModelSchema,
    WorkProductionModelSchema,
    ProductionTypeModelSchema,
    SaleModelSchema,
    SubSaleModelSchema,
    SaleTypeModelSchema,
    ConsumptionModelSchema,
    MaterialModelSchema,
    UnitOfMeasurementModelSchema,
  ];

  static Future<void> init() async {
    final document = await getApplicationDocumentsDirectory();
    isar = await Isar.open(schemes, directory: document.path);
  }

  Isar db() => isar;
}
