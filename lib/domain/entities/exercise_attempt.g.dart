// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_attempt.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseAttemptCollection on Isar {
  IsarCollection<ExerciseAttempt> get exerciseAttempts => this.collection();
}

const ExerciseAttemptSchema = CollectionSchema(
  name: r'ExerciseAttempt',
  id: -6389160222360501103,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'exerciseId': PropertySchema(
      id: 1,
      name: r'exerciseId',
      type: IsarType.long,
    ),
    r'mistakes': PropertySchema(
      id: 2,
      name: r'mistakes',
      type: IsarType.longList,
    ),
    r'score': PropertySchema(
      id: 3,
      name: r'score',
      type: IsarType.long,
    ),
    r'timeSpent': PropertySchema(
      id: 4,
      name: r'timeSpent',
      type: IsarType.long,
    ),
    r'total': PropertySchema(
      id: 5,
      name: r'total',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _exerciseAttemptEstimateSize,
  serialize: _exerciseAttemptSerialize,
  deserialize: _exerciseAttemptDeserialize,
  deserializeProp: _exerciseAttemptDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _exerciseAttemptGetId,
  getLinks: _exerciseAttemptGetLinks,
  attach: _exerciseAttemptAttach,
  version: '3.1.0+1',
);

int _exerciseAttemptEstimateSize(
  ExerciseAttempt object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mistakes.length * 8;
  return bytesCount;
}

void _exerciseAttemptSerialize(
  ExerciseAttempt object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.exerciseId);
  writer.writeLongList(offsets[2], object.mistakes);
  writer.writeLong(offsets[3], object.score);
  writer.writeLong(offsets[4], object.timeSpent);
  writer.writeLong(offsets[5], object.total);
  writer.writeLong(offsets[6], object.userId);
}

ExerciseAttempt _exerciseAttemptDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseAttempt(
    createdAt: reader.readDateTime(offsets[0]),
    exerciseId: reader.readLong(offsets[1]),
    id: id,
    mistakes: reader.readLongList(offsets[2]) ?? const [],
    score: reader.readLongOrNull(offsets[3]) ?? 0,
    timeSpent: reader.readLongOrNull(offsets[4]) ?? 0,
    total: reader.readLongOrNull(offsets[5]) ?? 0,
    userId: reader.readLong(offsets[6]),
  );
  return object;
}

P _exerciseAttemptDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? const []) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exerciseAttemptGetId(ExerciseAttempt object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _exerciseAttemptGetLinks(ExerciseAttempt object) {
  return [];
}

void _exerciseAttemptAttach(
    IsarCollection<dynamic> col, Id id, ExerciseAttempt object) {
  object.id = id;
}

extension ExerciseAttemptQueryWhereSort
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QWhere> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExerciseAttemptQueryWhere
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QWhereClause> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhereClause>
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

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterWhereClause> idBetween(
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

extension ExerciseAttemptQueryFilter
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QFilterCondition> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      exerciseIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      exerciseIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      exerciseIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      exerciseIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
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

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
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

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
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

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mistakes',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mistakes',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mistakes',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mistakes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      mistakesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'mistakes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      scoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      timeSpentEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeSpent',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      timeSpentGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeSpent',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      timeSpentLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeSpent',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      timeSpentBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeSpent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      totalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      totalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      totalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      totalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      userIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterFilterCondition>
      userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExerciseAttemptQueryObject
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QFilterCondition> {}

extension ExerciseAttemptQueryLinks
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QFilterCondition> {}

extension ExerciseAttemptQuerySortBy
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QSortBy> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByTimeSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSpent', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByTimeSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSpent', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ExerciseAttemptQuerySortThenBy
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QSortThenBy> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByExerciseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseId', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByTimeSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSpent', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByTimeSpentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeSpent', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ExerciseAttemptQueryWhereDistinct
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct> {
  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct>
      distinctByExerciseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseId');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct>
      distinctByMistakes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mistakes');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct>
      distinctByTimeSpent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeSpent');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }

  QueryBuilder<ExerciseAttempt, ExerciseAttempt, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension ExerciseAttemptQueryProperty
    on QueryBuilder<ExerciseAttempt, ExerciseAttempt, QQueryProperty> {
  QueryBuilder<ExerciseAttempt, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExerciseAttempt, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ExerciseAttempt, int, QQueryOperations> exerciseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseId');
    });
  }

  QueryBuilder<ExerciseAttempt, List<int>, QQueryOperations>
      mistakesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mistakes');
    });
  }

  QueryBuilder<ExerciseAttempt, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<ExerciseAttempt, int, QQueryOperations> timeSpentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeSpent');
    });
  }

  QueryBuilder<ExerciseAttempt, int, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }

  QueryBuilder<ExerciseAttempt, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
