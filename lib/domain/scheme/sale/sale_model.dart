import 'package:isar/isar.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'sale_model.g.dart';

@collection
class SaleModel {
  Id id = Isar.autoIncrement;

  late DateTime date;
  bool deposit = false;
  IsarLink<SaleTypeModel> saleType = IsarLink<SaleTypeModel>();
}

@collection
class SubSaleModel {
  Id id = Isar.autoIncrement;

  IsarLink<ProductionModel> lot = IsarLink<ProductionModel>();
  IsarLink<SaleModel> sale = IsarLink<SaleModel>();
  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();

  late int quantity;
  late int breaks;
}

@collection
class SaleTypeModel {
  Id id = Isar.autoIncrement;

  late String name;

  IsarLinks<SaleModel> sales = IsarLinks<SaleModel>();
}
