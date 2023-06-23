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

  lotName(ProductionTypeModel? type) {
    return DateFormat("ddMMyyyy").format(date);
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

  static Future<List<WorkProductionModel>> all({DateTime? dateTimeParam}) async {
    List<WorkProductionModel> list = await DBHelper.isar.workProductionModels.where().findAll();
    if (dateTimeParam != null) {
      DateFormat format = DateFormat(dateFormat);
      list = list.where((element) => format.format(element.datetime) == format.format(dateTimeParam)).toList();
    }

    return list;
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
