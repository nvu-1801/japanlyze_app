// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTranslationHistoryCollection on Isar {
  IsarCollection<TranslationHistory> get translationHistorys =>
      this.collection();
}

const TranslationHistorySchema = CollectionSchema(
  name: r'TranslationHistory',
  id: -1670349568942576793,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'sourceLang': PropertySchema(
      id: 1,
      name: r'sourceLang',
      type: IsarType.string,
    ),
    r'sourceText': PropertySchema(
      id: 2,
      name: r'sourceText',
      type: IsarType.string,
    ),
    r'starred': PropertySchema(
      id: 3,
      name: r'starred',
      type: IsarType.bool,
    ),
    r'targetLang': PropertySchema(
      id: 4,
      name: r'targetLang',
      type: IsarType.string,
    ),
    r'targetText': PropertySchema(
      id: 5,
      name: r'targetText',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 7,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _translationHistoryEstimateSize,
  serialize: _translationHistorySerialize,
  deserialize: _translationHistoryDeserialize,
  deserializeProp: _translationHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _translationHistoryGetId,
  getLinks: _translationHistoryGetLinks,
  attach: _translationHistoryAttach,
  version: '3.1.0+1',
);

int _translationHistoryEstimateSize(
  TranslationHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sourceLang.length * 3;
  bytesCount += 3 + object.sourceText.length * 3;
  bytesCount += 3 + object.targetLang.length * 3;
  bytesCount += 3 + object.targetText.length * 3;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _translationHistorySerialize(
  TranslationHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.sourceLang);
  writer.writeString(offsets[2], object.sourceText);
  writer.writeBool(offsets[3], object.starred);
  writer.writeString(offsets[4], object.targetLang);
  writer.writeString(offsets[5], object.targetText);
  writer.writeString(offsets[6], object.userId);
  writer.writeString(offsets[7], object.uuid);
}

TranslationHistory _translationHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TranslationHistory(
    createdAt: reader.readDateTime(offsets[0]),
    id: id,
    sourceLang: reader.readString(offsets[1]),
    sourceText: reader.readString(offsets[2]),
    starred: reader.readBoolOrNull(offsets[3]) ?? false,
    targetLang: reader.readString(offsets[4]),
    targetText: reader.readString(offsets[5]),
    userId: reader.readStringOrNull(offsets[6]),
    uuid: reader.readString(offsets[7]),
  );
  return object;
}

P _translationHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _translationHistoryGetId(TranslationHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _translationHistoryGetLinks(
    TranslationHistory object) {
  return [];
}

void _translationHistoryAttach(
    IsarCollection<dynamic> col, Id id, TranslationHistory object) {
  object.id = id;
}

extension TranslationHistoryQueryWhereSort
    on QueryBuilder<TranslationHistory, TranslationHistory, QWhere> {
  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TranslationHistoryQueryWhere
    on QueryBuilder<TranslationHistory, TranslationHistory, QWhereClause> {
  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhereClause>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterWhereClause>
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

extension TranslationHistoryQueryFilter
    on QueryBuilder<TranslationHistory, TranslationHistory, QFilterCondition> {
  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
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

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceLang',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceLang',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceLang',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceLangIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceLang',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceText',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      sourceTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceText',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      starredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starred',
        value: value,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetLang',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetLang',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetLang',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetLang',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetLangIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetLang',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetText',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      targetTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetText',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension TranslationHistoryQueryObject
    on QueryBuilder<TranslationHistory, TranslationHistory, QFilterCondition> {}

extension TranslationHistoryQueryLinks
    on QueryBuilder<TranslationHistory, TranslationHistory, QFilterCondition> {}

extension TranslationHistoryQuerySortBy
    on QueryBuilder<TranslationHistory, TranslationHistory, QSortBy> {
  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortBySourceLang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceLang', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortBySourceLangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceLang', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortBySourceText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceText', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortBySourceTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceText', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByStarred() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starred', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByStarredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starred', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByTargetLang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLang', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByTargetLangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLang', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByTargetText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetText', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByTargetTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetText', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TranslationHistoryQuerySortThenBy
    on QueryBuilder<TranslationHistory, TranslationHistory, QSortThenBy> {
  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenBySourceLang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceLang', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenBySourceLangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceLang', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenBySourceText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceText', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenBySourceTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceText', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByStarred() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starred', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByStarredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starred', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByTargetLang() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLang', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByTargetLangDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetLang', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByTargetText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetText', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByTargetTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetText', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TranslationHistoryQueryWhereDistinct
    on QueryBuilder<TranslationHistory, TranslationHistory, QDistinct> {
  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctBySourceLang({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceLang', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctBySourceText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByStarred() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starred');
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByTargetLang({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetLang', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByTargetText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TranslationHistory, TranslationHistory, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension TranslationHistoryQueryProperty
    on QueryBuilder<TranslationHistory, TranslationHistory, QQueryProperty> {
  QueryBuilder<TranslationHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TranslationHistory, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TranslationHistory, String, QQueryOperations>
      sourceLangProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceLang');
    });
  }

  QueryBuilder<TranslationHistory, String, QQueryOperations>
      sourceTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceText');
    });
  }

  QueryBuilder<TranslationHistory, bool, QQueryOperations> starredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starred');
    });
  }

  QueryBuilder<TranslationHistory, String, QQueryOperations>
      targetLangProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetLang');
    });
  }

  QueryBuilder<TranslationHistory, String, QQueryOperations>
      targetTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetText');
    });
  }

  QueryBuilder<TranslationHistory, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<TranslationHistory, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
