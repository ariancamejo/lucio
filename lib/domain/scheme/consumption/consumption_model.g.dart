// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConsumptionModelCollection on Isar {
  IsarCollection<ConsumptionModel> get consumptionModels => this.collection();
}

const ConsumptionModelSchema = CollectionSchema(
  name: r'ConsumptionModel',
  id: 7507188322299090804,
  properties: {
    r'quantityMaterial': PropertySchema(
      id: 0,
      name: r'quantityMaterial',
      type: IsarType.double,
    ),
    r'quantityType': PropertySchema(
      id: 1,
      name: r'quantityType',
      type: IsarType.double,
    )
  },
  estimateSize: _consumptionModelEstimateSize,
  serialize: _consumptionModelSerialize,
  deserialize: _consumptionModelDeserialize,
  deserializeProp: _consumptionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'type': LinkSchema(
      id: 4151842547179131498,
      name: r'type',
      target: r'ProductionTypeModel',
      single: true,
    ),
    r'material': LinkSchema(
      id: -3567763332916395800,
      name: r'material',
      target: r'MaterialModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _consumptionModelGetId,
  getLinks: _consumptionModelGetLinks,
  attach: _consumptionModelAttach,
  version: '3.1.0+1',
);

int _consumptionModelEstimateSize(
  ConsumptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _consumptionModelSerialize(
  ConsumptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.quantityMaterial);
  writer.writeDouble(offsets[1], object.quantityType);
}

ConsumptionModel _consumptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ConsumptionModel();
  object.id = id;
  object.quantityMaterial = reader.readDouble(offsets[0]);
  object.quantityType = reader.readDouble(offsets[1]);
  return object;
}

P _consumptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _consumptionModelGetId(ConsumptionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _consumptionModelGetLinks(ConsumptionModel object) {
  return [object.type, object.material];
}

void _consumptionModelAttach(
    IsarCollection<dynamic> col, Id id, ConsumptionModel object) {
  object.id = id;
  object.type
      .attach(col, col.isar.collection<ProductionTypeModel>(), r'type', id);
  object.material
      .attach(col, col.isar.collection<MaterialModel>(), r'material', id);
}

extension ConsumptionModelQueryWhereSort
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QWhere> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConsumptionModelQueryWhere
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QWhereClause> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhereClause>
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

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterWhereClause> idBetween(
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

extension ConsumptionModelQueryFilter
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QFilterCondition> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
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

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
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

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
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

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityMaterialEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityMaterial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityMaterialGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityMaterial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityMaterialLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityMaterial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityMaterialBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityMaterial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityTypeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantityType',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityTypeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantityType',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityTypeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantityType',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      quantityTypeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantityType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ConsumptionModelQueryObject
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QFilterCondition> {}

extension ConsumptionModelQueryLinks
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QFilterCondition> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition> type(
      FilterQuery<ProductionTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'type');
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'type', 0, true, 0, true);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      material(FilterQuery<MaterialModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'material');
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterFilterCondition>
      materialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'material', 0, true, 0, true);
    });
  }
}

extension ConsumptionModelQuerySortBy
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QSortBy> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      sortByQuantityMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityMaterial', Sort.asc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      sortByQuantityMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityMaterial', Sort.desc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      sortByQuantityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityType', Sort.asc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      sortByQuantityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityType', Sort.desc);
    });
  }
}

extension ConsumptionModelQuerySortThenBy
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QSortThenBy> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      thenByQuantityMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityMaterial', Sort.asc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      thenByQuantityMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityMaterial', Sort.desc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      thenByQuantityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityType', Sort.asc);
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QAfterSortBy>
      thenByQuantityTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantityType', Sort.desc);
    });
  }
}

extension ConsumptionModelQueryWhereDistinct
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QDistinct> {
  QueryBuilder<ConsumptionModel, ConsumptionModel, QDistinct>
      distinctByQuantityMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantityMaterial');
    });
  }

  QueryBuilder<ConsumptionModel, ConsumptionModel, QDistinct>
      distinctByQuantityType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantityType');
    });
  }
}

extension ConsumptionModelQueryProperty
    on QueryBuilder<ConsumptionModel, ConsumptionModel, QQueryProperty> {
  QueryBuilder<ConsumptionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ConsumptionModel, double, QQueryOperations>
      quantityMaterialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantityMaterial');
    });
  }

  QueryBuilder<ConsumptionModel, double, QQueryOperations>
      quantityTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantityType');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaterialModelCollection on Isar {
  IsarCollection<MaterialModel> get materialModels => this.collection();
}

const MaterialModelSchema = CollectionSchema(
  name: r'MaterialModel',
  id: 3663309223829163199,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _materialModelEstimateSize,
  serialize: _materialModelSerialize,
  deserialize: _materialModelDeserialize,
  deserializeProp: _materialModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'unit': LinkSchema(
      id: -1758408327560756525,
      name: r'unit',
      target: r'UnitOfMeasurementModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _materialModelGetId,
  getLinks: _materialModelGetLinks,
  attach: _materialModelAttach,
  version: '3.1.0+1',
);

int _materialModelEstimateSize(
  MaterialModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _materialModelSerialize(
  MaterialModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeString(offsets[1], object.name);
}

MaterialModel _materialModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaterialModel();
  object.color = reader.readLong(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  return object;
}

P _materialModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _materialModelGetId(MaterialModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _materialModelGetLinks(MaterialModel object) {
  return [object.unit];
}

void _materialModelAttach(
    IsarCollection<dynamic> col, Id id, MaterialModel object) {
  object.id = id;
  object.unit
      .attach(col, col.isar.collection<UnitOfMeasurementModel>(), r'unit', id);
}

extension MaterialModelQueryWhereSort
    on QueryBuilder<MaterialModel, MaterialModel, QWhere> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaterialModelQueryWhere
    on QueryBuilder<MaterialModel, MaterialModel, QWhereClause> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterWhereClause> idBetween(
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

extension MaterialModelQueryFilter
    on QueryBuilder<MaterialModel, MaterialModel, QFilterCondition> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
      colorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension MaterialModelQueryObject
    on QueryBuilder<MaterialModel, MaterialModel, QFilterCondition> {}

extension MaterialModelQueryLinks
    on QueryBuilder<MaterialModel, MaterialModel, QFilterCondition> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition> unit(
      FilterQuery<UnitOfMeasurementModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'unit');
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterFilterCondition>
      unitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'unit', 0, true, 0, true);
    });
  }
}

extension MaterialModelQuerySortBy
    on QueryBuilder<MaterialModel, MaterialModel, QSortBy> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension MaterialModelQuerySortThenBy
    on QueryBuilder<MaterialModel, MaterialModel, QSortThenBy> {
  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension MaterialModelQueryWhereDistinct
    on QueryBuilder<MaterialModel, MaterialModel, QDistinct> {
  QueryBuilder<MaterialModel, MaterialModel, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<MaterialModel, MaterialModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension MaterialModelQueryProperty
    on QueryBuilder<MaterialModel, MaterialModel, QQueryProperty> {
  QueryBuilder<MaterialModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaterialModel, int, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<MaterialModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUnitOfMeasurementModelCollection on Isar {
  IsarCollection<UnitOfMeasurementModel> get unitOfMeasurementModels =>
      this.collection();
}

const UnitOfMeasurementModelSchema = CollectionSchema(
  name: r'UnitOfMeasurementModel',
  id: 4247060822408243035,
  properties: {
    r'key': PropertySchema(
      id: 0,
      name: r'key',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 1,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _unitOfMeasurementModelEstimateSize,
  serialize: _unitOfMeasurementModelSerialize,
  deserialize: _unitOfMeasurementModelDeserialize,
  deserializeProp: _unitOfMeasurementModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'key': IndexSchema(
      id: -4906094122524121629,
      name: r'key',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'key',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _unitOfMeasurementModelGetId,
  getLinks: _unitOfMeasurementModelGetLinks,
  attach: _unitOfMeasurementModelAttach,
  version: '3.1.0+1',
);

int _unitOfMeasurementModelEstimateSize(
  UnitOfMeasurementModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _unitOfMeasurementModelSerialize(
  UnitOfMeasurementModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.key);
  writer.writeString(offsets[1], object.value);
}

UnitOfMeasurementModel _unitOfMeasurementModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UnitOfMeasurementModel();
  object.id = id;
  object.key = reader.readString(offsets[0]);
  object.value = reader.readString(offsets[1]);
  return object;
}

P _unitOfMeasurementModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _unitOfMeasurementModelGetId(UnitOfMeasurementModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _unitOfMeasurementModelGetLinks(
    UnitOfMeasurementModel object) {
  return [];
}

void _unitOfMeasurementModelAttach(
    IsarCollection<dynamic> col, Id id, UnitOfMeasurementModel object) {
  object.id = id;
}

extension UnitOfMeasurementModelByIndex
    on IsarCollection<UnitOfMeasurementModel> {
  Future<UnitOfMeasurementModel?> getByKey(String key) {
    return getByIndex(r'key', [key]);
  }

  UnitOfMeasurementModel? getByKeySync(String key) {
    return getByIndexSync(r'key', [key]);
  }

  Future<bool> deleteByKey(String key) {
    return deleteByIndex(r'key', [key]);
  }

  bool deleteByKeySync(String key) {
    return deleteByIndexSync(r'key', [key]);
  }

  Future<List<UnitOfMeasurementModel?>> getAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndex(r'key', values);
  }

  List<UnitOfMeasurementModel?> getAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'key', values);
  }

  Future<int> deleteAllByKey(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'key', values);
  }

  int deleteAllByKeySync(List<String> keyValues) {
    final values = keyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'key', values);
  }

  Future<Id> putByKey(UnitOfMeasurementModel object) {
    return putByIndex(r'key', object);
  }

  Id putByKeySync(UnitOfMeasurementModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'key', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByKey(List<UnitOfMeasurementModel> objects) {
    return putAllByIndex(r'key', objects);
  }

  List<Id> putAllByKeySync(List<UnitOfMeasurementModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'key', objects, saveLinks: saveLinks);
  }
}

extension UnitOfMeasurementModelQueryWhereSort
    on QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QWhere> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UnitOfMeasurementModelQueryWhere on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QWhereClause> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> keyEqualTo(String key) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'key',
        value: [key],
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterWhereClause> keyNotEqualTo(String key) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [key],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'key',
              lower: [],
              upper: [key],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UnitOfMeasurementModelQueryFilter on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QFilterCondition> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
          QAfterFilterCondition>
      keyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
          QAfterFilterCondition>
      keyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
          QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
          QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel,
      QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension UnitOfMeasurementModelQueryObject on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QFilterCondition> {}

extension UnitOfMeasurementModelQueryLinks on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QFilterCondition> {}

extension UnitOfMeasurementModelQuerySortBy
    on QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QSortBy> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UnitOfMeasurementModelQuerySortThenBy on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QSortThenBy> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QAfterSortBy>
      thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UnitOfMeasurementModelQueryWhereDistinct
    on QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QDistinct> {
  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QDistinct>
      distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UnitOfMeasurementModel, UnitOfMeasurementModel, QDistinct>
      distinctByValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value', caseSensitive: caseSensitive);
    });
  }
}

extension UnitOfMeasurementModelQueryProperty on QueryBuilder<
    UnitOfMeasurementModel, UnitOfMeasurementModel, QQueryProperty> {
  QueryBuilder<UnitOfMeasurementModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UnitOfMeasurementModel, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<UnitOfMeasurementModel, String, QQueryOperations>
      valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
