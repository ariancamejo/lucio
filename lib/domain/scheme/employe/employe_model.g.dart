// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employe_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmployeModelCollection on Isar {
  IsarCollection<EmployeModel> get employeModels => this.collection();
}

const EmployeModelSchema = CollectionSchema(
  name: r'EmployeModel',
  id: 7152147198668893167,
  properties: {
    r'ci': PropertySchema(
      id: 0,
      name: r'ci',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _employeModelEstimateSize,
  serialize: _employeModelSerialize,
  deserialize: _employeModelDeserialize,
  deserializeProp: _employeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'workProductions': LinkSchema(
      id: 8224396867538782105,
      name: r'workProductions',
      target: r'WorkProductionModel',
      single: false,
      linkName: r'employee',
    )
  },
  embeddedSchemas: {},
  getId: _employeModelGetId,
  getLinks: _employeModelGetLinks,
  attach: _employeModelAttach,
  version: '3.1.0+1',
);

int _employeModelEstimateSize(
  EmployeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ci;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _employeModelSerialize(
  EmployeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ci);
  writer.writeString(offsets[1], object.name);
}

EmployeModel _employeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmployeModel();
  object.ci = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  return object;
}

P _employeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _employeModelGetId(EmployeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _employeModelGetLinks(EmployeModel object) {
  return [object.workProductions];
}

void _employeModelAttach(
    IsarCollection<dynamic> col, Id id, EmployeModel object) {
  object.id = id;
  object.workProductions.attach(
      col, col.isar.collection<WorkProductionModel>(), r'workProductions', id);
}

extension EmployeModelQueryWhereSort
    on QueryBuilder<EmployeModel, EmployeModel, QWhere> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmployeModelQueryWhere
    on QueryBuilder<EmployeModel, EmployeModel, QWhereClause> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterWhereClause> idBetween(
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

extension EmployeModelQueryFilter
    on QueryBuilder<EmployeModel, EmployeModel, QFilterCondition> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ci',
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      ciIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ci',
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ci',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ci',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ci',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> ciIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ci',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      ciIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ci',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension EmployeModelQueryObject
    on QueryBuilder<EmployeModel, EmployeModel, QFilterCondition> {}

extension EmployeModelQueryLinks
    on QueryBuilder<EmployeModel, EmployeModel, QFilterCondition> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductions(FilterQuery<WorkProductionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workProductions');
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', length, true, length, true);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, 0, true);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, false, 999999, true);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workProductions', 0, true, length, include);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
      workProductionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'workProductions', length, include, 999999, true);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterFilterCondition>
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
}

extension EmployeModelQuerySortBy
    on QueryBuilder<EmployeModel, EmployeModel, QSortBy> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> sortByCi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ci', Sort.asc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> sortByCiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ci', Sort.desc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension EmployeModelQuerySortThenBy
    on QueryBuilder<EmployeModel, EmployeModel, QSortThenBy> {
  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenByCi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ci', Sort.asc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenByCiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ci', Sort.desc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension EmployeModelQueryWhereDistinct
    on QueryBuilder<EmployeModel, EmployeModel, QDistinct> {
  QueryBuilder<EmployeModel, EmployeModel, QDistinct> distinctByCi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ci', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeModel, EmployeModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension EmployeModelQueryProperty
    on QueryBuilder<EmployeModel, EmployeModel, QQueryProperty> {
  QueryBuilder<EmployeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmployeModel, String?, QQueryOperations> ciProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ci');
    });
  }

  QueryBuilder<EmployeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmployeePlanModelCollection on Isar {
  IsarCollection<EmployeePlanModel> get employeePlanModels => this.collection();
}

const EmployeePlanModelSchema = CollectionSchema(
  name: r'EmployeePlanModel',
  id: -1775472168628476647,
  properties: {
    r'plan': PropertySchema(
      id: 0,
      name: r'plan',
      type: IsarType.double,
    )
  },
  estimateSize: _employeePlanModelEstimateSize,
  serialize: _employeePlanModelSerialize,
  deserialize: _employeePlanModelDeserialize,
  deserializeProp: _employeePlanModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'employee': LinkSchema(
      id: 5080544669868915141,
      name: r'employee',
      target: r'EmployeModel',
      single: true,
    ),
    r'type': LinkSchema(
      id: -379538991873910233,
      name: r'type',
      target: r'ProductionTypeModel',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _employeePlanModelGetId,
  getLinks: _employeePlanModelGetLinks,
  attach: _employeePlanModelAttach,
  version: '3.1.0+1',
);

int _employeePlanModelEstimateSize(
  EmployeePlanModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _employeePlanModelSerialize(
  EmployeePlanModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.plan);
}

EmployeePlanModel _employeePlanModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmployeePlanModel();
  object.id = id;
  object.plan = reader.readDouble(offsets[0]);
  return object;
}

P _employeePlanModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _employeePlanModelGetId(EmployeePlanModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _employeePlanModelGetLinks(
    EmployeePlanModel object) {
  return [object.employee, object.type];
}

void _employeePlanModelAttach(
    IsarCollection<dynamic> col, Id id, EmployeePlanModel object) {
  object.id = id;
  object.employee
      .attach(col, col.isar.collection<EmployeModel>(), r'employee', id);
  object.type
      .attach(col, col.isar.collection<ProductionTypeModel>(), r'type', id);
}

extension EmployeePlanModelQueryWhereSort
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QWhere> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmployeePlanModelQueryWhere
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QWhereClause> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhereClause>
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

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterWhereClause>
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

extension EmployeePlanModelQueryFilter
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QFilterCondition> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
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

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
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

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
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

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      planEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      planGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      planLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plan',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      planBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension EmployeePlanModelQueryObject
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QFilterCondition> {}

extension EmployeePlanModelQueryLinks
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QFilterCondition> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      employee(FilterQuery<EmployeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'employee');
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      employeeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'employee', 0, true, 0, true);
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      type(FilterQuery<ProductionTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'type');
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterFilterCondition>
      typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'type', 0, true, 0, true);
    });
  }
}

extension EmployeePlanModelQuerySortBy
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QSortBy> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy>
      sortByPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plan', Sort.asc);
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy>
      sortByPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plan', Sort.desc);
    });
  }
}

extension EmployeePlanModelQuerySortThenBy
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QSortThenBy> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy>
      thenByPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plan', Sort.asc);
    });
  }

  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QAfterSortBy>
      thenByPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plan', Sort.desc);
    });
  }
}

extension EmployeePlanModelQueryWhereDistinct
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QDistinct> {
  QueryBuilder<EmployeePlanModel, EmployeePlanModel, QDistinct>
      distinctByPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plan');
    });
  }
}

extension EmployeePlanModelQueryProperty
    on QueryBuilder<EmployeePlanModel, EmployeePlanModel, QQueryProperty> {
  QueryBuilder<EmployeePlanModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmployeePlanModel, double, QQueryOperations> planProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plan');
    });
  }
}
