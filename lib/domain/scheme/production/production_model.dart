import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:lucio/data/const.dart';
import 'package:lucio/device/helpers/storage/database.dart';
import 'package:lucio/domain/scheme/employe/employe_model.dart';
import 'package:lucio/domain/scheme/sale/sale_model.dart';

part 'production_model.g.dart';

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

    return object?.workProductions.where((element) => element.type.value != null).map((e) => e.type.value!).toSet().toList() ?? [];
  }

  lotName(ProductionTypeModel? type) {
    return DateFormat("ddMMyyyy").format(date);
  }

  Future<int> forSale(ProductionTypeModel? type, {bool available = true}) async {
    if (type == null) return 0;

    if (!available) {
      List<WorkProductionModel> stock =
          await DBHelper.isar.workProductionModels.filter().production((q) => q.idEqualTo(id)).type((q) => q.idEqualTo(type.id)).listForSaleGreaterThan(DateTime.now()).findAll();
      int stockSum = stock.fold(0, (sum, item) => sum + item.quantity);
      return stockSum;
    }

    List<WorkProductionModel> stock =
        await DBHelper.isar.workProductionModels.filter().production((q) => q.idEqualTo(id)).type((q) => q.idEqualTo(type.id)).listForSaleLessThan(DateTime.now()).findAll();

    List<SubSaleModel> sold = await DBHelper.isar.subSaleModels.filter().lot((q) => q.idEqualTo(id)).type((q) => q.idEqualTo(type.id)).findAll();
    int stockSum = stock.fold(0, (sum, item) => sum + item.quantity);
    int soldSum = sold.fold(0, (sum, item) => sum + item.quantity + item.breaks);
    int result = stockSum - soldSum;
    return result;
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
  late int quantity;
  late int breaks;

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

  @Backlink(to: 'type')
  final workProductions = IsarLinks<WorkProductionModel>();

  @Backlink(to: 'type')
  final subsales = IsarLinks<SubSaleModel>();
}
