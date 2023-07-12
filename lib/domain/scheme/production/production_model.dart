import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/repositories/production/work_production_provider.dart';
import 'package:lucio/data/repositories/sales/sub_sales_provider.dart';

import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/consumption/consumption_model.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

part 'production_model.g.dart';

enum ProductionTypeResult { all, process, available, sold, real, breaks }

@collection
class ProductionModel {
  Id id = Isar.autoIncrement;

  late DateTime date;

  @Backlink(to: 'production')
  final workProductions = IsarLinks<WorkProductionModel>();

  @Backlink(to: 'lot')
  final subsales = IsarLinks<SubSaleModel>();

  Future<List<ProductionTypeModel>> types() async {
    final object = await DBHelper.isar.productionModels.filter().idEqualTo(id).findFirst();
    final types = object?.workProductions.where((element) => element.type.value != null).map((e) => e.type.value!).toList() ?? [];

    final uniqueTypes = <ProductionTypeModel>{};
    for (final type in types) {
      if (!uniqueTypes.any((t) => t.id == type.id)) {
        uniqueTypes.add(type);
      }
    }

    return uniqueTypes.toList();
  }

  double breaksPercent({required List<WorkProductionModel> productions, bool breaks = true, bool withOutP = false}) {
    List<WorkProductionModel> filtered = productions;
    if (!withOutP) {
      filtered = productions.where((element) => element.production.value?.id == id).toList();
    }

    float totalSum = filtered.fold(0, (sum, item) => sum + item.quantity);
    print(totalSum);

    float quantitySum = filtered.fold(0, (sum, item) => sum + item.quantity - item.breaks);
    float breaksSum = filtered.fold(0, (sum, item) => sum + item.breaks);

    return totalSum == 0 ? 0 : ((breaks ? breaksSum : quantitySum) / totalSum) * 100;
  }

  lotName(ProductionTypeModel? type) {
    return DateFormat("ddMMyyyy").format(date);
  }

  float detailsNoSync(List<WorkProductionModel> workProductionProvider, List<SubSaleModel> subsalesProvider, ProductionTypeModel? type,
      {required ProductionTypeResult typeResult, bool withOutP = false}) {
    if (type == null) return 0;

    List<SubSaleModel> soldAll = subsalesProvider.where((element) => element.lot.value?.id == id && element.type.value?.id == type.id).toList();

    List<WorkProductionModel> stockAll = workProductionProvider.where((element) => element.production.value?.id == id && element.type.value?.id == type.id).toList();

    if (withOutP) {
      soldAll = subsalesProvider.where((element) => element.type.value?.id == type.id).toList();
      stockAll = workProductionProvider.where((element) => element.type.value?.id == type.id).toList();
    }

    if (typeResult == ProductionTypeResult.available) {
      List<WorkProductionModel> stock = stockAll.where((element) => element.listForSale.isBefore(DateTime.now())).toList();
      float stockSum = stock.fold(0, (sum, item) => sum + item.quantity - item.breaks);
      float soldSum = soldAll.fold(0, (sum, item) => sum + item.quantity);

      float result = stockSum - soldSum;
      return result;
    }

    if (typeResult == ProductionTypeResult.process) {
      List<WorkProductionModel> stock = stockAll.where((element) => element.listForSale.isAfter(DateTime.now())).toList();
      float stockSum = stock.fold(0, (sum, item) => sum + item.quantity - item.breaks);
      return stockSum;
    }

    if (typeResult == ProductionTypeResult.all) {
      float stockSum = stockAll.fold(0, (sum, item) => sum + item.quantity);
      return stockSum;
    }
    if (typeResult == ProductionTypeResult.sold) {
      float soldSum = soldAll.fold(0, (sum, item) => sum + item.quantity);
      return soldSum;
    }

    if (typeResult == ProductionTypeResult.real) {
      float stockSum = stockAll.fold(0, (sum, item) => sum + item.quantity - item.breaks);
      return stockSum;
    }
    if (typeResult == ProductionTypeResult.breaks) {
      float stockSum = stockAll.fold(0, (sum, item) => sum + item.breaks);
      return stockSum;
    }
    return 0;
  }
}

@collection
class WorkProductionModel {
  Id id = Isar.autoIncrement;
  IsarLink<ProductionModel> production = IsarLink<ProductionModel>();
  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();
  IsarLink<EmployeModel> employee = IsarLink<EmployeModel>();
  late DateTime datetime;
  late DateTime listForSale;
  late double quantity;
  late double breaks;

  DateTime? readyIn() {
    return listForSale.isAfter(DateTime.now()) ? listForSale : null;
  }
}

@collection
class ProductionTypeModel {
  Id id = Isar.autoIncrement;
  late String name;
  late int color;
  int daysToBeReady = 17;
  late double price;
  IsarLink<UnitOfMeasurementModel> unit = IsarLink<UnitOfMeasurementModel>();

  @Backlink(to: 'type')
  final workProductions = IsarLinks<WorkProductionModel>();

  @Backlink(to: 'type')
  final subsales = IsarLinks<SubSaleModel>();
}
