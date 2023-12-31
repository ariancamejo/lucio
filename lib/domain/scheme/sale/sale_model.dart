import 'package:isar/isar.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'sale_model.g.dart';

enum SaleTypeResult { all, withoutlot, withlot, real, breaks }

@collection
class SaleModel {
  Id id = Isar.autoIncrement;
  late DateTime date;
  bool deposit = false;
  bool pendingSales = false;
  late String client;

  IsarLink<SaleTypeModel> saleType = IsarLink<SaleTypeModel>();

  @Backlink(to: 'sale')
  final subsales = IsarLinks<SubSaleModel>();

  SaleModel() {
    date = DateTime.now();
  }

  double breaksPercent({required List<SubSaleModel> subsales, bool breaks = true, bool withOutP = false}) {
    List<SubSaleModel> filtered = subsales;
    if (!withOutP) {
      filtered = subsales.where((element) => element.sale.value?.id == id).toList();
    }

    float totalSum = filtered.fold(0, (sum, item) => sum + item.quantity);

    float quantitySum = filtered.fold(0, (sum, item) => sum + item.quantity - item.breaks);
    float breaksSum = filtered.fold(0, (sum, item) => sum + item.breaks);

    return totalSum == 0 ? 0 : ((breaks ? breaksSum : quantitySum) / totalSum) * 100;
  }

  Future<List<ProductionTypeModel>> types() async {
    final object = await DBHelper.isar.saleModels.filter().idEqualTo(id).findFirst();
    final types = object?.subsales.where((element) => element.type.value != null).map((e) => e.type.value!).toList() ?? [];

    final uniqueTypes = <ProductionTypeModel>{};
    for (final type in types) {
      if (!uniqueTypes.any((t) => t.id == type.id)) {
        uniqueTypes.add(type);
      }
    }
    return uniqueTypes.toList();
  }

  Future<bool> checkPendingSales() async {
    return await DBHelper.isar.subSaleModels.filter().sale((q) => q.idEqualTo(id)).lotIsNull().count() > 0;
  }

  Future<float> saled(ProductionTypeModel type, {required SaleTypeResult typeResult, bool withOutP = false}) async {
    List<SubSaleModel> sold = [];

    if (withOutP) {
      sold = await DBHelper.isar.subSaleModels.where().findAll();
    } else {
      SaleModel? sale = await DBHelper.isar.saleModels.filter().idEqualTo(id).findFirst();
      if (sale == null) return 0;
      sold = sale.subsales.toList();
    }
    sold = subsales.where((element) => element.type.value?.id == type.id).toList();
    if (typeResult == SaleTypeResult.all) {
      float soldSum = sold.fold(0, (sum, item) => sum + item.quantity);
      return soldSum;
    }

    if (typeResult == SaleTypeResult.real) {
      float soldSum = sold.fold(0, (sum, item) => sum + item.quantity - item.breaks);
      return soldSum;
    }
    if (typeResult == SaleTypeResult.breaks) {
      float soldSum = sold.fold(0, (sum, item) => sum + item.breaks);
      return soldSum;
    }

    if (typeResult == SaleTypeResult.withoutlot) {
      sold = sold.where((element) => element.lot.value == null).toList();
    }

    if (typeResult == SaleTypeResult.withlot) {
      sold = sold.where((element) => element.lot.value != null).toList();
    }

    float soldSum = sold.fold(0, (sum, item) => sum + item.quantity);
    return soldSum;
  }
}

@collection
class SubSaleModel {
  Id id = Isar.autoIncrement;

  IsarLink<ProductionModel> lot = IsarLink<ProductionModel>();
  IsarLink<SaleModel> sale = IsarLink<SaleModel>();
  IsarLink<ProductionTypeModel> type = IsarLink<ProductionTypeModel>();
  late DateTime datetime;
  late double quantity;
  late double breaks;

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
