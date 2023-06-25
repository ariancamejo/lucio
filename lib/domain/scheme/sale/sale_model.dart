import 'package:isar/isar.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/production/production_model.dart';

part 'sale_model.g.dart';

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

  Future<List<ProductionTypeModel>> types() async {
    final object = await DBHelper.isar.saleModels.filter().idEqualTo(id).findFirst();

    return object?.subsales.where((element) => element.type.value != null).map((e) => e.type.value!).toSet().toList() ?? [];
  }

  Future<bool> checkPendingSales() async {
    return await DBHelper.isar.subSaleModels.filter().sale((q) => q.idEqualTo(id)).lotIsNull().count() > 0;
  }

  Future<int> saled(ProductionTypeModel type, {bool pending = false}) async {
    SaleModel? sale = await DBHelper.isar.saleModels.filter().idEqualTo(id).findFirst();
    if (sale == null) return 0;

    List<SubSaleModel> sold = [];
    if (pending) {
      sold = sale.subsales.where((element) => element.lot.value == null && element.type.value?.id == type.id).toList();
    } else {
      sold = sale.subsales.where((element) => element.lot.value != null && element.type.value?.id == type.id).toList();
    }

    int soldSum = sold.fold(0, (sum, item) => sum + item.quantity + item.breaks);
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
