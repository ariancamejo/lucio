import 'package:isar/isar.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'consumption_model.g.dart';

@collection
class ConsumptionModel {
  Id id = Isar.autoIncrement;

  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();
  IsarLink<MaterialModel> material = IsarLink<MaterialModel>();
  late double quantityType;
  late double quantityMaterial;

  double quantity(double cantType) {
    return (cantType / quantityType) * quantityMaterial;
  }
}

@collection
class MaterialModel {
  Id id = Isar.autoIncrement;
  late String name;
  IsarLink<UnitOfMeasurementModel> unit = IsarLink<UnitOfMeasurementModel>();
  late int color;
}

@collection
class UnitOfMeasurementModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String key;
  late String value;
}
