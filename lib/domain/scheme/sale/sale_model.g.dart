// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSaleModelCollection on Isar {
  IsarCollection<SaleModel> get saleModels => this.collection();
}

const SaleModelSchema = CollectionSchema(
  name: r'SaleModel',
  id: 8410161235942925352,
  properties: {
    r'client': PropertySchema(
      id: 0,
      name: r'client',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'deposit': PropertySchema(
      id: 2,
      name: r'deposit',
      type: IsarType.bool,
    ),
    r'pendingSales': PropertySchema(
      id: 3,
      name: r'pendingSales',
      type: IsarType.bool,
    )
  },
  estimateSize: _saleModelEstimateSize,
  serialize: _saleModelSerialize,
  deserialize: _saleModelDeserialize,
  deserializeProp: _saleModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'saleType': LinkSchema(
      id: 1000980421410329251,
      name: r'saleType',
      target: r'SaleTypeModel',
      single: true,
    ),
    r'subsales': LinkSchema(
      id: -1996678040081549157,
      name: r'subsales',
      target: r'SubSaleModel',
      single: false,
      linkName: r'sale',
    )
  },
  embeddedSchemas: {},
  getId: _saleModelGetId,
  getLinks: _saleModelGetLinks,
  attach: _saleModelAttach,
  version: '3.1.0+1',
);

int _saleModelEstimateSize(
  SaleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.client.length * 3;
  return bytesCount;
}

void _saleModelSerialize(
  SaleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.client);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeBool(offsets[2], object.deposit);
  writer.writeBool(offsets[3], object.pendingSales);
}

SaleModel _saleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SaleModel();
  object.client = reader.readString(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.deposit = reader.readBool(offsets[2]);
  object.id = id;
  object.pendingSales = reader.readBool(offsets[3]);
  return object;
}

P _saleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _saleModelGetId(SaleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _saleModelGetLinks(SaleModel object) {
  return [object.saleType, object.subsales];
}

void _saleModelAttach(IsarCollection<dynamic> col, Id id, SaleModel object) {
  object.id = id;
  object.saleType
      .attach(col, col.isar.collection<SaleTypeModel>(), r'saleType', id);
  object.subsales
      .attach(col, col.isar.collection<SubSaleModel>(), r'subsales', id);
}

extension SaleModelQueryWhereSort
    on QueryBuilder<SaleModel, SaleModel, QWhere> {
  QueryBuilder<SaleModel, SaleModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SaleModelQueryWhere
    on QueryBuilder<SaleModel, SaleModel, QWhereClause> {
  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterWhereClause> idBetween(
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

extension SaleModelQueryFilter
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {
  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'client',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'client',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'client',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> clientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'client',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> depositEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deposit',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> pendingSalesEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingSales',
        value: value,
      ));
    });
  }
}

extension SaleModelQueryObject
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {}

extension SaleModelQueryLinks
    on QueryBuilder<SaleModel, SaleModel, QFilterCondition> {
  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> saleType(
      FilterQuery<SaleTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'saleType');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> saleTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'saleType', 0, true, 0, true);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> subsales(
      FilterQuery<SubSaleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'subsales');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      subsalesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, true, length, true);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition> subsalesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, 0, true);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      subsalesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, false, 999999, true);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      subsalesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', 0, true, length, include);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
      subsalesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'subsales', length, include, 999999, true);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterFilterCondition>
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

extension SaleModelQuerySortBy on QueryBuilder<SaleModel, SaleModel, QSortBy> {
  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByClient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByClientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByDeposit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deposit', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByDepositDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deposit', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByPendingSales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSales', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> sortByPendingSalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSales', Sort.desc);
    });
  }
}

extension SaleModelQuerySortThenBy
    on QueryBuilder<SaleModel, SaleModel, QSortThenBy> {
  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByClient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByClientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByDeposit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deposit', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByDepositDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deposit', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByPendingSales() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSales', Sort.asc);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QAfterSortBy> thenByPendingSalesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSales', Sort.desc);
    });
  }
}

extension SaleModelQueryWhereDistinct
    on QueryBuilder<SaleModel, SaleModel, QDistinct> {
  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByClient(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'client', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByDeposit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deposit');
    });
  }

  QueryBuilder<SaleModel, SaleModel, QDistinct> distinctByPendingSales() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSales');
    });
  }
}

extension SaleModelQueryProperty
    on QueryBuilder<SaleModel, SaleModel, QQueryProperty> {
  QueryBuilder<SaleModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SaleModel, String, QQueryOperations> clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'client');
    });
  }

  QueryBuilder<SaleModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<SaleModel, bool, QQueryOperations> depositProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deposit');
    });
  }

  QueryBuilder<SaleModel, bool, QQueryOperations> pendingSalesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSales');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubSaleModelCollection on Isar {
  IsarCollection<SubSaleModel> get subSaleModels => this.collection();
}

const SubSaleModelSchema = CollectionSchema(
  name: r'SubSaleModel',
  id: -1498524712193814775,
  properties: {
    r'breaks': PropertySchema(
      id: 0,
      name: r'breaks',
      type: IsarType.double,
    ),
    r'datetime': PropertySchema(
      id: 1,
      name: r'datetime',
      type: IsarType.dateTime,
    ),
    r'quantity': PropertySchema(
      id: 2,
      name: r'quantity',
      type: IsarType.double,
    )
  },
  estimateSize: _subSaleModelEstimateSize,
  serialize: _subSaleModelSerialize,
  deserialize: _subSaleModelDeserialize,
  deserializeProp: _subSaleModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'lot': LinkSchema(
      id: 3361269550011512978,
      name: r'lot',
      target: r'ProductionModel',
      single: true,
    ),
    r'sale': LinkSchema(
      id: -6935648111008214591,
      name: r'sale',
      target: r'SaleModel',
      single: true,
    ),
    r'type': LinkSchema(
      id: -490145985903070662,
      name: r'type',
      target: r'ProductionTypeModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _subSaleModelGetId,
  getLinks: _subSaleModelGetLinks,
  attach: _subSaleModelAttach,
  version: '3.1.0+1',
);

int _subSaleModelEstimateSize(
  SubSaleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _subSaleModelSerialize(
  SubSaleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.breaks);
  writer.writeDateTime(offsets[1], object.datetime);
  writer.writeDouble(offsets[2], object.quantity);
}

SubSaleModel _subSaleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubSaleModel();
  object.breaks = reader.readDouble(offsets[0]);
  object.datetime = reader.readDateTime(offsets[1]);
  object.id = id;
  object.quantity = reader.readDouble(offsets[2]);
  return object;
}

P _subSaleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subSaleModelGetId(SubSaleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subSaleModelGetLinks(SubSaleModel object) {
  return [object.lot, object.sale, object.type];
}

void _subSaleModelAttach(
    IsarCollection<dynamic> col, Id id, SubSaleModel object) {
  object.id = id;
  object.lot.attach(col, col.isar.collection<ProductionModel>(), r'lot', id);
  object.sale.attach(col, col.isar.collection<SaleModel>(), r'sale', id);
  object.type
      .attach(col, col.isar.collection<ProductionTypeModel>(), r'type', id);
}

extension SubSaleModelQueryWhereSort
    on QueryBuilder<SubSaleModel, SubSaleModel, QWhere> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SubSaleModelQueryWhere
    on QueryBuilder<SubSaleModel, SubSaleModel, QWhereClause> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterWhereClause> idBetween(
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

extension SubSaleModelQueryFilter
    on QueryBuilder<SubSaleModel, SubSaleModel, QFilterCondition> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> breaksEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breaks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      breaksGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breaks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      breaksLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breaks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> breaksBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breaks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      datetimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'datetime',
        value: value,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension SubSaleModelQueryObject
    on QueryBuilder<SubSaleModel, SubSaleModel, QFilterCondition> {}

extension SubSaleModelQueryLinks
    on QueryBuilder<SubSaleModel, SubSaleModel, QFilterCondition> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> lot(
      FilterQuery<ProductionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lot');
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> lotIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lot', 0, true, 0, true);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> sale(
      FilterQuery<SaleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sale');
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> saleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sale', 0, true, 0, true);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> type(
      FilterQuery<ProductionTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'type');
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'type', 0, true, 0, true);
    });
  }
}

extension SubSaleModelQuerySortBy
    on QueryBuilder<SubSaleModel, SubSaleModel, QSortBy> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByBreaksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.desc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension SubSaleModelQuerySortThenBy
    on QueryBuilder<SubSaleModel, SubSaleModel, QSortThenBy> {
  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByBreaksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breaks', Sort.desc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByDatetimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'datetime', Sort.desc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QAfterSortBy> thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension SubSaleModelQueryWhereDistinct
    on QueryBuilder<SubSaleModel, SubSaleModel, QDistinct> {
  QueryBuilder<SubSaleModel, SubSaleModel, QDistinct> distinctByBreaks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breaks');
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QDistinct> distinctByDatetime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'datetime');
    });
  }

  QueryBuilder<SubSaleModel, SubSaleModel, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension SubSaleModelQueryProperty
    on QueryBuilder<SubSaleModel, SubSaleModel, QQueryProperty> {
  QueryBuilder<SubSaleModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubSaleModel, double, QQueryOperations> breaksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breaks');
    });
  }

  QueryBuilder<SubSaleModel, DateTime, QQueryOperations> datetimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'datetime');
    });
  }

  QueryBuilder<SubSaleModel, double, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSaleTypeModelCollection on Isar {
  IsarCollection<SaleTypeModel> get saleTypeModels => this.collection();
}

const SaleTypeModelSchema = CollectionSchema(
  name: r'SaleTypeModel',
  id: 7045829742406661983,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _saleTypeModelEstimateSize,
  serialize: _saleTypeModelSerialize,
  deserialize: _saleTypeModelDeserialize,
  deserializeProp: _saleTypeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'sales': LinkSchema(
      id: -9180123139455372458,
      name: r'sales',
      target: r'SaleModel',
      single: false,
      linkName: r'saleType',
    )
  },
  embeddedSchemas: {},
  getId: _saleTypeModelGetId,
  getLinks: _saleTypeModelGetLinks,
  attach: _saleTypeModelAttach,
  version: '3.1.0+1',
);

int _saleTypeModelEstimateSize(
  SaleTypeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _saleTypeModelSerialize(
  SaleTypeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

SaleTypeModel _saleTypeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SaleTypeModel();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  return object;
}

P _saleTypeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _saleTypeModelGetId(SaleTypeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _saleTypeModelGetLinks(SaleTypeModel object) {
  return [object.sales];
}

void _saleTypeModelAttach(
    IsarCollection<dynamic> col, Id id, SaleTypeModel object) {
  object.id = id;
  object.sales.attach(col, col.isar.collection<SaleModel>(), r'sales', id);
}

extension SaleTypeModelQueryWhereSort
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QWhere> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SaleTypeModelQueryWhere
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QWhereClause> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterWhereClause> idBetween(
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

extension SaleTypeModelQueryFilter
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QFilterCondition> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
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

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension SaleTypeModelQueryObject
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QFilterCondition> {}

extension SaleTypeModelQueryLinks
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QFilterCondition> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition> sales(
      FilterQuery<SaleModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sales');
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sales', length, true, length, true);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sales', 0, true, 0, true);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sales', 0, false, 999999, true);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sales', 0, true, length, include);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sales', length, include, 999999, true);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterFilterCondition>
      salesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'sales', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SaleTypeModelQuerySortBy
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QSortBy> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SaleTypeModelQuerySortThenBy
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QSortThenBy> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SaleTypeModel, SaleTypeModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SaleTypeModelQueryWhereDistinct
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QDistinct> {
  QueryBuilder<SaleTypeModel, SaleTypeModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension SaleTypeModelQueryProperty
    on QueryBuilder<SaleTypeModel, SaleTypeModel, QQueryProperty> {
  QueryBuilder<SaleTypeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SaleTypeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
