// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductionModelCollection on Isar {
  IsarCollection<ProductionModel> get productionModels => this.collection();
}

const ProductionModelSchema = CollectionSchema(
  name: r'ProductionModel',
  id: 8768361426598395785,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _productionModelEstimateSize,
  serialize: _productionModelSerialize,
  deserialize: _productionModelDeserialize,
  deserializeProp: _productionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'workProductions': LinkSchema(
      id: -3761217119391727974,
      name: r'workProductions',
      target: r'WorkProductionModel',
      single: false,
      linkName: r'production',
    ),
    r'subsales': LinkSchema(
      id: 3879340026832286364,
      name: r'subsales',
      target: r'SubSaleModel',
      single: false,
      linkName: r'lot',
    )
  },
  embeddedSchemas: {},
  getId: _productionModelGetId,
  getLinks: _productionModelGetLinks,
  attach: _productionModelAttach,
  version: '3.1.0+1',
);

int _productionModelEstimateSize(
  ProductionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _productionModelSerialize(
  ProductionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
}

ProductionModel _productionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductionModel();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  return object;
}

P _productionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productionModelGetId(ProductionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _productionModelGetLinks(ProductionModel object) {
  return [object.workProductions, object.subsales];
}

void _productionModelAttach(
    IsarCollection<dynamic> col, Id id, ProductionModel object) {
  object.id = id;
  object.workProductions.attach(
      col, col.isar.collection<WorkProductionModel>(), r'workProductions', id);
  object.subsales
      .attach(col, col.isar.collection<SubSaleModel>(), r'subsales', id);
}

extension ProductionModelQueryWhereSort
    on QueryBuilder<ProductionModel, ProductionModel, QWhere> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProductionModelQueryWhere
    on QueryBuilder<ProductionModel, ProductionModel, QWhereClause> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductionModelQueryFilter
    on QueryBuilder<ProductionModel, ProductionModel, QFilterCondition> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductionModelQueryObject
    on QueryBuilder<ProductionModel, ProductionModel, QFilterCondition> {}

extension ProductionModelQueryLinks
    on QueryBuilder<ProductionModel, ProductionModel, QFilterCondition> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductions(FilterQuery<WorkProductionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workProductions');
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', length, true, length, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, 0, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, length, include);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workProductions', length, include, 999999, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      workProductionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workProductions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsales(FilterQuery<SubSaleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subsales');
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, true, length, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, 0, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, length, include);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, include, 999999, true);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterFilterCondition>
      subsalesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'subsales', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ProductionModelQuerySortBy
    on QueryBuilder<ProductionModel, ProductionModel, QSortBy> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }
}

extension ProductionModelQuerySortThenBy
    on QueryBuilder<ProductionModel, ProductionModel, QSortThenBy> {
  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductionModel, ProductionModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ProductionModelQueryWhereDistinct
    on QueryBuilder<ProductionModel, ProductionModel, QDistinct> {
  QueryBuilder<ProductionModel, ProductionModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }
}

extension ProductionModelQueryProperty
    on QueryBuilder<ProductionModel, ProductionModel, QQueryProperty> {
  QueryBuilder<ProductionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProductionModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkProductionModelCollection on Isar {
  IsarCollection<WorkProductionModel> get workProductionModels =>
      this.collection();
}

const WorkProductionModelSchema = CollectionSchema(
  name: r'WorkProductionModel',
  id: 2441816943197644401,
  properties: {
    r'breaks': PropertySchema(
      id: 0,
      name: r'breaks',
      type: IsarType.long,
    ),
    r'datetime': PropertySchema(
      id: 1,
      name: r'datetime',
      type: IsarType.dateTime,
    ),
    r'listForSale': PropertySchema(
      id: 2,
      name: r'listForSale',
      type: IsarType.dateTime,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.long,
    )
  },
  estimateSize: _workProductionModelEstimateSize,
  serialize: _workProductionModelSerialize,
  deserialize: _workProductionModelDeserialize,
  deserializeProp: _workProductionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'production': LinkSchema(
      id: -1522331128335731037,
      name: r'production',
      target: r'ProductionModel',
      single: true,
    ),
    r'type': LinkSchema(
      id: 7698029715465460929,
      name: r'type',
      target: r'ProductionTypeModel',
      single: true,
    ),
    r'employee': LinkSchema(
      id: -7302089305010052875,
      name: r'employee',
      target: r'EmployeModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _workProductionModelGetId,
  getLinks: _workProductionModelGetLinks,
  attach: _workProductionModelAttach,
  version: '3.1.0+1',
);

int _workProductionModelEstimateSize(
  WorkProductionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _workProductionModelSerialize(
  WorkProductionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breaks);
  writer.writeDateTime(offsets[1], object.datetime);
  writer.writeDateTime(offsets[2], object.listForSale);
  writer.writeLong(offsets[3], object.quantity);
}

WorkProductionModel _workProductionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkProductionModel();
  object.breaks = reader.readLong(offsets[0]);
  object.datetime = reader.readDateTime(offsets[1]);
  object.id = id;
  object.listForSale = reader.readDateTime(offsets[2]);
  object.quantity = reader.readLong(offsets[3]);
  return object;
}

P _workProductionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workProductionModelGetId(WorkProductionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workProductionModelGetLinks(
    WorkProductionModel object) {
  return [object.production, object.type, object.employee];
}

void _workProductionModelAttach(
    IsarCollection<dynamic> col, Id id, WorkProductionModel object) {
  object.id = id;
  object.production
      .attach(col, col.isar.collection<ProductionModel>(), r'production', id);
  object.type
      .attach(col, col.isar.collection<ProductionTypeModel>(), r'type', id);
  object.employee
      .attach(col, col.isar.collection<EmployeModel>(), r'employee', id);
}

extension WorkProductionModelQueryWhereSort
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QWhere> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkProductionModelQueryWhere
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QWhereClause> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkProductionModelQueryFilter on QueryBuilder<WorkProductionModel,
    WorkProductionModel, QFilterCondition> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      breaksEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breaks',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      breaksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breaks',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      breaksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breaks',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      breaksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breaks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      datetimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      datetimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      datetimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      datetimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'datetime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      listForSaleEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listForSale',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      listForSaleGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listForSale',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      listForSaleLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listForSale',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      listForSaleBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listForSale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkProductionModelQueryObject on QueryBuilder<WorkProductionModel,
    WorkProductionModel, QFilterCondition> {}

extension WorkProductionModelQueryLinks on QueryBuilder<WorkProductionModel,
    WorkProductionModel, QFilterCondition> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      production(FilterQuery<ProductionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'production');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      productionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'production', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      type(FilterQuery<ProductionTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'type');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'type', 0, true, 0, true);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      employee(FilterQuery<EmployeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'employee');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterFilterCondition>
      employeeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'employee', 0, true, 0, true);
    });
  }
}

extension WorkProductionModelQuerySortBy
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QSortBy> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByBreaksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByListForSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listForSale', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByListForSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listForSale', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension WorkProductionModelQuerySortThenBy
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QSortThenBy> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByBreaksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByListForSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listForSale', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByListForSaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listForSale', Sort.desc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension WorkProductionModelQueryWhereDistinct
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QDistinct> {
  QueryBuilder<WorkProductionModel, WorkProductionModel, QDistinct>
      distinctByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breaks');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QDistinct>
      distinctByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datetime');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QDistinct>
      distinctByListForSale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listForSale');
    });
  }

  QueryBuilder<WorkProductionModel, WorkProductionModel, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension WorkProductionModelQueryProperty
    on QueryBuilder<WorkProductionModel, WorkProductionModel, QQueryProperty> {
  QueryBuilder<WorkProductionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkProductionModel, int, QQueryOperations> breaksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breaks');
    });
  }

  QueryBuilder<WorkProductionModel, DateTime, QQueryOperations>
      datetimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datetime');
    });
  }

  QueryBuilder<WorkProductionModel, DateTime, QQueryOperations>
      listForSaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listForSale');
    });
  }

  QueryBuilder<WorkProductionModel, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductionTypeModelCollection on Isar {
  IsarCollection<ProductionTypeModel> get productionTypeModels =>
      this.collection();
}

const ProductionTypeModelSchema = CollectionSchema(
  name: r'ProductionTypeModel',
  id: -6039639729735812746,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'daysToBeReady': PropertySchema(
      id: 1,
      name: r'daysToBeReady',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 3,
      name: r'price',
      type: IsarType.double,
    )
  },
  estimateSize: _productionTypeModelEstimateSize,
  serialize: _productionTypeModelSerialize,
  deserialize: _productionTypeModelDeserialize,
  deserializeProp: _productionTypeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'workProductions': LinkSchema(
      id: -5726313727196098587,
      name: r'workProductions',
      target: r'WorkProductionModel',
      single: false,
      linkName: r'type',
    ),
    r'subsales': LinkSchema(
      id: -152422954719474460,
      name: r'subsales',
      target: r'SubSaleModel',
      single: false,
      linkName: r'type',
    )
  },
  embeddedSchemas: {},
  getId: _productionTypeModelGetId,
  getLinks: _productionTypeModelGetLinks,
  attach: _productionTypeModelAttach,
  version: '3.1.0+1',
);

int _productionTypeModelEstimateSize(
  ProductionTypeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _productionTypeModelSerialize(
  ProductionTypeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeLong(offsets[1], object.daysToBeReady);
  writer.writeString(offsets[2], object.name);
  writer.writeDouble(offsets[3], object.price);
}

ProductionTypeModel _productionTypeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductionTypeModel();
  object.color = reader.readLong(offsets[0]);
  object.daysToBeReady = reader.readLong(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.price = reader.readDouble(offsets[3]);
  return object;
}

P _productionTypeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productionTypeModelGetId(ProductionTypeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _productionTypeModelGetLinks(
    ProductionTypeModel object) {
  return [object.workProductions, object.subsales];
}

void _productionTypeModelAttach(
    IsarCollection<dynamic> col, Id id, ProductionTypeModel object) {
  object.id = id;
  object.workProductions.attach(
      col, col.isar.collection<WorkProductionModel>(), r'workProductions', id);
  object.subsales
      .attach(col, col.isar.collection<SubSaleModel>(), r'subsales', id);
}

extension ProductionTypeModelQueryWhereSort
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QWhere> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProductionTypeModelQueryWhere
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QWhereClause> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductionTypeModelQueryFilter on QueryBuilder<ProductionTypeModel,
    ProductionTypeModel, QFilterCondition> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      colorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      daysToBeReadyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysToBeReady',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      daysToBeReadyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysToBeReady',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      daysToBeReadyLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysToBeReady',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      daysToBeReadyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysToBeReady',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ProductionTypeModelQueryObject on QueryBuilder<ProductionTypeModel,
    ProductionTypeModel, QFilterCondition> {}

extension ProductionTypeModelQueryLinks on QueryBuilder<ProductionTypeModel,
    ProductionTypeModel, QFilterCondition> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductions(FilterQuery<WorkProductionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workProductions');
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', length, true, length, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, 0, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, length, include);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workProductions', length, include, 999999, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      workProductionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workProductions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsales(FilterQuery<SubSaleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subsales');
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, true, length, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, 0, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, false, 999999, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, length, include);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, include, 999999, true);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterFilterCondition>
      subsalesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'subsales', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ProductionTypeModelQuerySortBy
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QSortBy> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByDaysToBeReady() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToBeReady', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByDaysToBeReadyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToBeReady', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension ProductionTypeModelQuerySortThenBy
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QSortThenBy> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByDaysToBeReady() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToBeReady', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByDaysToBeReadyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToBeReady', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QAfterSortBy>
      thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension ProductionTypeModelQueryWhereDistinct
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QDistinct> {
  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QDistinct>
      distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QDistinct>
      distinctByDaysToBeReady() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysToBeReady');
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductionTypeModel, ProductionTypeModel, QDistinct>
      distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }
}

extension ProductionTypeModelQueryProperty
    on QueryBuilder<ProductionTypeModel, ProductionTypeModel, QQueryProperty> {
  QueryBuilder<ProductionTypeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProductionTypeModel, int, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<ProductionTypeModel, int, QQueryOperations>
      daysToBeReadyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysToBeReady');
    });
  }

  QueryBuilder<ProductionTypeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ProductionTypeModel, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }
}
