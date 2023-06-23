import 'package:isar/isar.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'sale_model.g.dart';

@collection
class SaleModel {
  Id id = Isar.autoIncrement;
  late DateTime date;
  bool deposit = false;
  late String client;

  IsarLink<SaleTypeModel> saleType = IsarLink<SaleTypeModel>();

  @Backlink(to: 'sale')
  final subsales = IsarLinks<SubSaleModel>();

  SaleModel() {
    date = DateTime.now();
  }
}

@collection
class SubSaleModel {
  Id id = Isar.autoIncrement;

  IsarLink<ProductionModel> lot = IsarLink<ProductionModel>();
  IsarLink<SaleModel> sale = IsarLink<SaleModel>();
  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();
  late DateTime datetime;
  late int quantity;
  late int breaks;

  SubSaleModel() {
    datetime = DateTime.now();
  }
}

@collection
class SaleTypeModel {
  Id id = Isar.autoIncrement;

  late String name;

  @Backlink(to: 'saleType')
  final sales = IsarLinks<SaleModel>();
}
