// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashcardItemCollection on Isar {
  IsarCollection<FlashcardItem> get flashcardItems => this.collection();
}

const FlashcardItemSchema = CollectionSchema(
  name: r'FlashcardItem',
  id: -9191743303447364249,
  properties: {
    r'cardId': PropertySchema(
      id: 0,
      name: r'cardId',
      type: IsarType.string,
    ),
    r'correctCount': PropertySchema(
      id: 1,
      name: r'correctCount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'easeFactor': PropertySchema(
      id: 3,
      name: r'easeFactor',
      type: IsarType.double,
    ),
    r'example': PropertySchema(
      id: 4,
      name: r'example',
      type: IsarType.string,
    ),
    r'exampleMeaning': PropertySchema(
      id: 5,
      name: r'exampleMeaning',
      type: IsarType.string,
    ),
    r'incorrectCount': PropertySchema(
      id: 6,
      name: r'incorrectCount',
      type: IsarType.long,
    ),
    r'interval': PropertySchema(
      id: 7,
      name: r'interval',
      type: IsarType.long,
    ),
    r'isDue': PropertySchema(
      id: 8,
      name: r'isDue',
      type: IsarType.bool,
    ),
    r'isMastered': PropertySchema(
      id: 9,
      name: r'isMastered',
      type: IsarType.bool,
    ),
    r'japanese': PropertySchema(
      id: 10,
      name: r'japanese',
      type: IsarType.string,
    ),
    r'kana': PropertySchema(
      id: 11,
      name: r'kana',
      type: IsarType.string,
    ),
    r'lastRatingIndex': PropertySchema(
      id: 12,
      name: r'lastRatingIndex',
      type: IsarType.long,
    ),
    r'lastReviewDate': PropertySchema(
      id: 13,
      name: r'lastReviewDate',
      type: IsarType.dateTime,
    ),
    r'meaning': PropertySchema(
      id: 14,
      name: r'meaning',
      type: IsarType.string,
    ),
    r'nextReviewDate': PropertySchema(
      id: 15,
      name: r'nextReviewDate',
      type: IsarType.dateTime,
    ),
    r'note': PropertySchema(
      id: 16,
      name: r'note',
      type: IsarType.string,
    ),
    r'questId': PropertySchema(
      id: 17,
      name: r'questId',
      type: IsarType.string,
    ),
    r'repetitions': PropertySchema(
      id: 18,
      name: r'repetitions',
      type: IsarType.long,
    ),
    r'romaji': PropertySchema(
      id: 19,
      name: r'romaji',
      type: IsarType.string,
    ),
    r'srsLevel': PropertySchema(
      id: 20,
      name: r'srsLevel',
      type: IsarType.byte,
      enumMap: _FlashcardItemsrsLevelEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 21,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _flashcardItemEstimateSize,
  serialize: _flashcardItemSerialize,
  deserialize: _flashcardItemDeserialize,
  deserializeProp: _flashcardItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'cardId': IndexSchema(
      id: -8501089313549364976,
      name: r'cardId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'cardId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'questId': IndexSchema(
      id: -312090079606683354,
      name: r'questId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'questId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'nextReviewDate': IndexSchema(
      id: 4152658090540413903,
      name: r'nextReviewDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nextReviewDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _flashcardItemGetId,
  getLinks: _flashcardItemGetLinks,
  attach: _flashcardItemAttach,
  version: '3.1.0+1',
);

int _flashcardItemEstimateSize(
  FlashcardItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cardId.length * 3;
  {
    final value = object.example;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.exampleMeaning;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.japanese.length * 3;
  bytesCount += 3 + object.kana.length * 3;
  bytesCount += 3 + object.meaning.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.questId.length * 3;
  bytesCount += 3 + object.romaji.length * 3;
  return bytesCount;
}

void _flashcardItemSerialize(
  FlashcardItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cardId);
  writer.writeLong(offsets[1], object.correctCount);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDouble(offsets[3], object.easeFactor);
  writer.writeString(offsets[4], object.example);
  writer.writeString(offsets[5], object.exampleMeaning);
  writer.writeLong(offsets[6], object.incorrectCount);
  writer.writeLong(offsets[7], object.interval);
  writer.writeBool(offsets[8], object.isDue);
  writer.writeBool(offsets[9], object.isMastered);
  writer.writeString(offsets[10], object.japanese);
  writer.writeString(offsets[11], object.kana);
  writer.writeLong(offsets[12], object.lastRatingIndex);
  writer.writeDateTime(offsets[13], object.lastReviewDate);
  writer.writeString(offsets[14], object.meaning);
  writer.writeDateTime(offsets[15], object.nextReviewDate);
  writer.writeString(offsets[16], object.note);
  writer.writeString(offsets[17], object.questId);
  writer.writeLong(offsets[18], object.repetitions);
  writer.writeString(offsets[19], object.romaji);
  writer.writeByte(offsets[20], object.srsLevel.index);
  writer.writeDateTime(offsets[21], object.updatedAt);
}

FlashcardItem _flashcardItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashcardItem();
  object.cardId = reader.readString(offsets[0]);
  object.correctCount = reader.readLong(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.easeFactor = reader.readDouble(offsets[3]);
  object.example = reader.readStringOrNull(offsets[4]);
  object.exampleMeaning = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.incorrectCount = reader.readLong(offsets[6]);
  object.interval = reader.readLong(offsets[7]);
  object.isMastered = reader.readBool(offsets[9]);
  object.japanese = reader.readString(offsets[10]);
  object.kana = reader.readString(offsets[11]);
  object.lastRatingIndex = reader.readLongOrNull(offsets[12]);
  object.lastReviewDate = reader.readDateTimeOrNull(offsets[13]);
  object.meaning = reader.readString(offsets[14]);
  object.nextReviewDate = reader.readDateTime(offsets[15]);
  object.note = reader.readStringOrNull(offsets[16]);
  object.questId = reader.readString(offsets[17]);
  object.repetitions = reader.readLong(offsets[18]);
  object.romaji = reader.readString(offsets[19]);
  object.srsLevel =
      _FlashcardItemsrsLevelValueEnumMap[reader.readByteOrNull(offsets[20])] ??
          SRSLevel.newCard;
  object.updatedAt = reader.readDateTime(offsets[21]);
  return object;
}

P _flashcardItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (_FlashcardItemsrsLevelValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SRSLevel.newCard) as P;
    case 21:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FlashcardItemsrsLevelEnumValueMap = {
  'newCard': 0,
  'learning': 1,
  'review': 2,
  'relearning': 3,
};
const _FlashcardItemsrsLevelValueEnumMap = {
  0: SRSLevel.newCard,
  1: SRSLevel.learning,
  2: SRSLevel.review,
  3: SRSLevel.relearning,
};

Id _flashcardItemGetId(FlashcardItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashcardItemGetLinks(FlashcardItem object) {
  return [];
}

void _flashcardItemAttach(
    IsarCollection<dynamic> col, Id id, FlashcardItem object) {
  object.id = id;
}

extension FlashcardItemQueryWhereSort
    on QueryBuilder<FlashcardItem, FlashcardItem, QWhere> {
  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhere> anyNextReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nextReviewDate'),
      );
    });
  }
}

extension FlashcardItemQueryWhere
    on QueryBuilder<FlashcardItem, FlashcardItem, QWhereClause> {
  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> cardIdEqualTo(
      String cardId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cardId',
        value: [cardId],
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      cardIdNotEqualTo(String cardId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardId',
              lower: [],
              upper: [cardId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardId',
              lower: [cardId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardId',
              lower: [cardId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cardId',
              lower: [],
              upper: [cardId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause> questIdEqualTo(
      String questId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'questId',
        value: [questId],
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      questIdNotEqualTo(String questId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      nextReviewDateEqualTo(DateTime nextReviewDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextReviewDate',
        value: [nextReviewDate],
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      nextReviewDateNotEqualTo(DateTime nextReviewDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextReviewDate',
              lower: [],
              upper: [nextReviewDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextReviewDate',
              lower: [nextReviewDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextReviewDate',
              lower: [nextReviewDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextReviewDate',
              lower: [],
              upper: [nextReviewDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      nextReviewDateGreaterThan(
    DateTime nextReviewDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextReviewDate',
        lower: [nextReviewDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      nextReviewDateLessThan(
    DateTime nextReviewDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextReviewDate',
        lower: [],
        upper: [nextReviewDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterWhereClause>
      nextReviewDateBetween(
    DateTime lowerNextReviewDate,
    DateTime upperNextReviewDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextReviewDate',
        lower: [lowerNextReviewDate],
        includeLower: includeLower,
        upper: [upperNextReviewDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FlashcardItemQueryFilter
    on QueryBuilder<FlashcardItem, FlashcardItem, QFilterCondition> {
  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cardId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cardId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cardId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cardId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      cardIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cardId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      correctCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      correctCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correctCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      correctCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correctCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      correctCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correctCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      easeFactorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      easeFactorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      easeFactorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      easeFactorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'easeFactor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'example',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'example',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'example',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'example',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'example',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'example',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'example',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exampleMeaning',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exampleMeaning',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exampleMeaning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exampleMeaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exampleMeaning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exampleMeaning',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      exampleMeaningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exampleMeaning',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      incorrectCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incorrectCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      incorrectCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'incorrectCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      incorrectCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'incorrectCount',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      incorrectCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'incorrectCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      intervalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      intervalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      intervalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      intervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      isDueEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDue',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      isMasteredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMastered',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'japanese',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'japanese',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'japanese',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'japanese',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      japaneseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'japanese',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> kanaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> kanaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kana',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> kanaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kana',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kana',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      kanaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kana',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRatingIndex',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRatingIndex',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRatingIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRatingIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRatingIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastRatingIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRatingIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReviewDate',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReviewDate',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      lastReviewDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReviewDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meaning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meaning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      meaningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      nextReviewDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      nextReviewDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      nextReviewDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextReviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      nextReviewDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextReviewDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      questIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      repetitionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      repetitionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      repetitionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      repetitionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repetitions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'romaji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'romaji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'romaji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'romaji',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      romajiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'romaji',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      srsLevelEqualTo(SRSLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'srsLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      srsLevelGreaterThan(
    SRSLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'srsLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      srsLevelLessThan(
    SRSLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'srsLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      srsLevelBetween(
    SRSLevel lower,
    SRSLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'srsLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FlashcardItemQueryObject
    on QueryBuilder<FlashcardItem, FlashcardItem, QFilterCondition> {}

extension FlashcardItemQueryLinks
    on QueryBuilder<FlashcardItem, FlashcardItem, QFilterCondition> {}

extension FlashcardItemQuerySortBy
    on QueryBuilder<FlashcardItem, FlashcardItem, QSortBy> {
  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByCorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByEaseFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByExample() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'example', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByExampleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'example', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByExampleMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exampleMeaning', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByExampleMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exampleMeaning', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByIncorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByIsDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDue', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByIsDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDue', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByIsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMastered', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByIsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMastered', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByJapanese() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'japanese', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByJapaneseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'japanese', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByKana() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kana', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByKanaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kana', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByLastRatingIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRatingIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByLastRatingIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRatingIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByLastReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewDate', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByLastReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewDate', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByNextReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewDate', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByNextReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewDate', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByRepetitionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByRomaji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'romaji', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByRomajiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'romaji', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortBySrsLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srsLevel', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortBySrsLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srsLevel', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardItemQuerySortThenBy
    on QueryBuilder<FlashcardItem, FlashcardItem, QSortThenBy> {
  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cardId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByCorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByEaseFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByExample() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'example', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByExampleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'example', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByExampleMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exampleMeaning', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByExampleMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exampleMeaning', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByIncorrectCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectCount', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByIsDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDue', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByIsDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDue', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByIsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMastered', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByIsMasteredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMastered', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByJapanese() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'japanese', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByJapaneseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'japanese', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByKana() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kana', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByKanaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kana', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByLastRatingIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRatingIndex', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByLastRatingIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRatingIndex', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByLastReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewDate', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByLastReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewDate', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByNextReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewDate', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByNextReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewDate', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByRepetitionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByRomaji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'romaji', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByRomajiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'romaji', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenBySrsLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srsLevel', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenBySrsLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'srsLevel', Sort.desc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardItemQueryWhereDistinct
    on QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> {
  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByCardId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cardId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByCorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctCount');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'easeFactor');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByExample(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'example', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByExampleMeaning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exampleMeaning',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByIncorrectCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incorrectCount');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interval');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByIsDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDue');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByIsMastered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMastered');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByJapanese(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'japanese', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByKana(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kana', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByLastRatingIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRatingIndex');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByLastReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReviewDate');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByMeaning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByNextReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextReviewDate');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByQuestId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct>
      distinctByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repetitions');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByRomaji(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'romaji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctBySrsLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'srsLevel');
    });
  }

  QueryBuilder<FlashcardItem, FlashcardItem, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FlashcardItemQueryProperty
    on QueryBuilder<FlashcardItem, FlashcardItem, QQueryProperty> {
  QueryBuilder<FlashcardItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> cardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cardId');
    });
  }

  QueryBuilder<FlashcardItem, int, QQueryOperations> correctCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctCount');
    });
  }

  QueryBuilder<FlashcardItem, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FlashcardItem, double, QQueryOperations> easeFactorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'easeFactor');
    });
  }

  QueryBuilder<FlashcardItem, String?, QQueryOperations> exampleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'example');
    });
  }

  QueryBuilder<FlashcardItem, String?, QQueryOperations>
      exampleMeaningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exampleMeaning');
    });
  }

  QueryBuilder<FlashcardItem, int, QQueryOperations> incorrectCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incorrectCount');
    });
  }

  QueryBuilder<FlashcardItem, int, QQueryOperations> intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interval');
    });
  }

  QueryBuilder<FlashcardItem, bool, QQueryOperations> isDueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDue');
    });
  }

  QueryBuilder<FlashcardItem, bool, QQueryOperations> isMasteredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMastered');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> japaneseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'japanese');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> kanaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kana');
    });
  }

  QueryBuilder<FlashcardItem, int?, QQueryOperations>
      lastRatingIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRatingIndex');
    });
  }

  QueryBuilder<FlashcardItem, DateTime?, QQueryOperations>
      lastReviewDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReviewDate');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> meaningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaning');
    });
  }

  QueryBuilder<FlashcardItem, DateTime, QQueryOperations>
      nextReviewDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextReviewDate');
    });
  }

  QueryBuilder<FlashcardItem, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> questIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questId');
    });
  }

  QueryBuilder<FlashcardItem, int, QQueryOperations> repetitionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repetitions');
    });
  }

  QueryBuilder<FlashcardItem, String, QQueryOperations> romajiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'romaji');
    });
  }

  QueryBuilder<FlashcardItem, SRSLevel, QQueryOperations> srsLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'srsLevel');
    });
  }

  QueryBuilder<FlashcardItem, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashcardDeckCollection on Isar {
  IsarCollection<FlashcardDeck> get flashcardDecks => this.collection();
}

const FlashcardDeckSchema = CollectionSchema(
  name: r'FlashcardDeck',
  id: 2663524640301590320,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deckId': PropertySchema(
      id: 1,
      name: r'deckId',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'dueCards': PropertySchema(
      id: 3,
      name: r'dueCards',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 4,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'masteredCards': PropertySchema(
      id: 5,
      name: r'masteredCards',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 6,
      name: r'progress',
      type: IsarType.double,
    ),
    r'questId': PropertySchema(
      id: 7,
      name: r'questId',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalCards': PropertySchema(
      id: 9,
      name: r'totalCards',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _flashcardDeckEstimateSize,
  serialize: _flashcardDeckSerialize,
  deserialize: _flashcardDeckDeserialize,
  deserializeProp: _flashcardDeckDeserializeProp,
  idName: r'id',
  indexes: {
    r'deckId': IndexSchema(
      id: -1182505463565197889,
      name: r'deckId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deckId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'questId': IndexSchema(
      id: -312090079606683354,
      name: r'questId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'questId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _flashcardDeckGetId,
  getLinks: _flashcardDeckGetLinks,
  attach: _flashcardDeckAttach,
  version: '3.1.0+1',
);

int _flashcardDeckEstimateSize(
  FlashcardDeck object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deckId.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.questId.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _flashcardDeckSerialize(
  FlashcardDeck object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.deckId);
  writer.writeString(offsets[2], object.description);
  writer.writeLong(offsets[3], object.dueCards);
  writer.writeBool(offsets[4], object.isCompleted);
  writer.writeLong(offsets[5], object.masteredCards);
  writer.writeDouble(offsets[6], object.progress);
  writer.writeString(offsets[7], object.questId);
  writer.writeString(offsets[8], object.title);
  writer.writeLong(offsets[9], object.totalCards);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

FlashcardDeck _flashcardDeckDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashcardDeck();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.deckId = reader.readString(offsets[1]);
  object.description = reader.readStringOrNull(offsets[2]);
  object.dueCards = reader.readLong(offsets[3]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[4]);
  object.masteredCards = reader.readLong(offsets[5]);
  object.progress = reader.readDouble(offsets[6]);
  object.questId = reader.readString(offsets[7]);
  object.title = reader.readString(offsets[8]);
  object.totalCards = reader.readLong(offsets[9]);
  object.updatedAt = reader.readDateTime(offsets[10]);
  return object;
}

P _flashcardDeckDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _flashcardDeckGetId(FlashcardDeck object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashcardDeckGetLinks(FlashcardDeck object) {
  return [];
}

void _flashcardDeckAttach(
    IsarCollection<dynamic> col, Id id, FlashcardDeck object) {
  object.id = id;
}

extension FlashcardDeckQueryWhereSort
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QWhere> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashcardDeckQueryWhere
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QWhereClause> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> idBetween(
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> deckIdEqualTo(
      String deckId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deckId',
        value: [deckId],
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause>
      deckIdNotEqualTo(String deckId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckId',
              lower: [],
              upper: [deckId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckId',
              lower: [deckId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckId',
              lower: [deckId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deckId',
              lower: [],
              upper: [deckId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause> questIdEqualTo(
      String questId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'questId',
        value: [questId],
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterWhereClause>
      questIdNotEqualTo(String questId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FlashcardDeckQueryFilter
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QFilterCondition> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deckId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deckId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deckId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deckId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      deckIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deckId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      dueCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      dueCardsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      dueCardsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      dueCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueCards',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      masteredCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'masteredCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      masteredCardsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'masteredCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      masteredCardsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'masteredCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      masteredCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'masteredCards',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      questIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      totalCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      totalCardsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      totalCardsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCards',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      totalCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCards',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FlashcardDeckQueryObject
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QFilterCondition> {}

extension FlashcardDeckQueryLinks
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QFilterCondition> {}

extension FlashcardDeckQuerySortBy
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QSortBy> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByDueCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByDueCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByMasteredCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masteredCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByMasteredCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masteredCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardDeckQuerySortThenBy
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QSortThenBy> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByDeckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByDeckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deckId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByDueCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByDueCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByMasteredCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masteredCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByMasteredCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masteredCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByTotalCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCards', Sort.desc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension FlashcardDeckQueryWhereDistinct
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> {
  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByDeckId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deckId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByDueCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueCards');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct>
      distinctByMasteredCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'masteredCards');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByQuestId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByTotalCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCards');
    });
  }

  QueryBuilder<FlashcardDeck, FlashcardDeck, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension FlashcardDeckQueryProperty
    on QueryBuilder<FlashcardDeck, FlashcardDeck, QQueryProperty> {
  QueryBuilder<FlashcardDeck, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashcardDeck, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FlashcardDeck, String, QQueryOperations> deckIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deckId');
    });
  }

  QueryBuilder<FlashcardDeck, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<FlashcardDeck, int, QQueryOperations> dueCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueCards');
    });
  }

  QueryBuilder<FlashcardDeck, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<FlashcardDeck, int, QQueryOperations> masteredCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'masteredCards');
    });
  }

  QueryBuilder<FlashcardDeck, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<FlashcardDeck, String, QQueryOperations> questIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questId');
    });
  }

  QueryBuilder<FlashcardDeck, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<FlashcardDeck, int, QQueryOperations> totalCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCards');
    });
  }

  QueryBuilder<FlashcardDeck, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserProgressHistoryCollection on Isar {
  IsarCollection<UserProgressHistory> get userProgressHistorys =>
      this.collection();
}

const UserProgressHistorySchema = CollectionSchema(
  name: r'UserProgressHistory',
  id: 2752025977959805259,
  properties: {
    r'correctAnswers': PropertySchema(
      id: 0,
      name: r'correctAnswers',
      type: IsarType.long,
    ),
    r'durationSeconds': PropertySchema(
      id: 1,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'endedAt': PropertySchema(
      id: 2,
      name: r'endedAt',
      type: IsarType.dateTime,
    ),
    r'historyId': PropertySchema(
      id: 3,
      name: r'historyId',
      type: IsarType.string,
    ),
    r'incorrectAnswers': PropertySchema(
      id: 4,
      name: r'incorrectAnswers',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 5,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'itemsReviewed': PropertySchema(
      id: 6,
      name: r'itemsReviewed',
      type: IsarType.long,
    ),
    r'progress': PropertySchema(
      id: 7,
      name: r'progress',
      type: IsarType.double,
    ),
    r'questId': PropertySchema(
      id: 8,
      name: r'questId',
      type: IsarType.string,
    ),
    r'sessionType': PropertySchema(
      id: 9,
      name: r'sessionType',
      type: IsarType.string,
    ),
    r'startedAt': PropertySchema(
      id: 10,
      name: r'startedAt',
      type: IsarType.dateTime,
    ),
    r'xpEarned': PropertySchema(
      id: 11,
      name: r'xpEarned',
      type: IsarType.long,
    )
  },
  estimateSize: _userProgressHistoryEstimateSize,
  serialize: _userProgressHistorySerialize,
  deserialize: _userProgressHistoryDeserialize,
  deserializeProp: _userProgressHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'questId': IndexSchema(
      id: -312090079606683354,
      name: r'questId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'questId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userProgressHistoryGetId,
  getLinks: _userProgressHistoryGetLinks,
  attach: _userProgressHistoryAttach,
  version: '3.1.0+1',
);

int _userProgressHistoryEstimateSize(
  UserProgressHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.historyId.length * 3;
  bytesCount += 3 + object.questId.length * 3;
  bytesCount += 3 + object.sessionType.length * 3;
  return bytesCount;
}

void _userProgressHistorySerialize(
  UserProgressHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.correctAnswers);
  writer.writeLong(offsets[1], object.durationSeconds);
  writer.writeDateTime(offsets[2], object.endedAt);
  writer.writeString(offsets[3], object.historyId);
  writer.writeLong(offsets[4], object.incorrectAnswers);
  writer.writeBool(offsets[5], object.isCompleted);
  writer.writeLong(offsets[6], object.itemsReviewed);
  writer.writeDouble(offsets[7], object.progress);
  writer.writeString(offsets[8], object.questId);
  writer.writeString(offsets[9], object.sessionType);
  writer.writeDateTime(offsets[10], object.startedAt);
  writer.writeLong(offsets[11], object.xpEarned);
}

UserProgressHistory _userProgressHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserProgressHistory();
  object.correctAnswers = reader.readLong(offsets[0]);
  object.durationSeconds = reader.readLong(offsets[1]);
  object.endedAt = reader.readDateTime(offsets[2]);
  object.historyId = reader.readString(offsets[3]);
  object.id = id;
  object.incorrectAnswers = reader.readLong(offsets[4]);
  object.isCompleted = reader.readBool(offsets[5]);
  object.itemsReviewed = reader.readLong(offsets[6]);
  object.progress = reader.readDouble(offsets[7]);
  object.questId = reader.readString(offsets[8]);
  object.sessionType = reader.readString(offsets[9]);
  object.startedAt = reader.readDateTime(offsets[10]);
  object.xpEarned = reader.readLong(offsets[11]);
  return object;
}

P _userProgressHistoryDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userProgressHistoryGetId(UserProgressHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userProgressHistoryGetLinks(
    UserProgressHistory object) {
  return [];
}

void _userProgressHistoryAttach(
    IsarCollection<dynamic> col, Id id, UserProgressHistory object) {
  object.id = id;
}

extension UserProgressHistoryQueryWhereSort
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QWhere> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserProgressHistoryQueryWhere
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QWhereClause> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
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

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
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

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
      questIdEqualTo(String questId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'questId',
        value: [questId],
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterWhereClause>
      questIdNotEqualTo(String questId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [questId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questId',
              lower: [],
              upper: [questId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserProgressHistoryQueryFilter on QueryBuilder<UserProgressHistory,
    UserProgressHistory, QFilterCondition> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      correctAnswersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      correctAnswersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correctAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      correctAnswersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correctAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      correctAnswersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correctAnswers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      endedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      endedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      endedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      endedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'historyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'historyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'historyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'historyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      historyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'historyId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
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

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
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

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
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

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      incorrectAnswersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incorrectAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      incorrectAnswersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'incorrectAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      incorrectAnswersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'incorrectAnswers',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      incorrectAnswersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'incorrectAnswers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      itemsReviewedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      itemsReviewedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      itemsReviewedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      itemsReviewedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemsReviewed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      questIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sessionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sessionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      sessionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sessionType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      startedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      startedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      startedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      startedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      xpEarnedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      xpEarnedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      xpEarnedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xpEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterFilterCondition>
      xpEarnedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xpEarned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserProgressHistoryQueryObject on QueryBuilder<UserProgressHistory,
    UserProgressHistory, QFilterCondition> {}

extension UserProgressHistoryQueryLinks on QueryBuilder<UserProgressHistory,
    UserProgressHistory, QFilterCondition> {}

extension UserProgressHistoryQuerySortBy
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QSortBy> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByHistoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyId', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByHistoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyId', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByIncorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByIncorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByItemsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsReviewed', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByItemsReviewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsReviewed', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortBySessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortBySessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      sortByXpEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.desc);
    });
  }
}

extension UserProgressHistoryQuerySortThenBy
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QSortThenBy> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByHistoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyId', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByHistoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'historyId', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByIncorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectAnswers', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByIncorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incorrectAnswers', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByItemsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsReviewed', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByItemsReviewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsReviewed', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenBySessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenBySessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.asc);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QAfterSortBy>
      thenByXpEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpEarned', Sort.desc);
    });
  }
}

extension UserProgressHistoryQueryWhereDistinct
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct> {
  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswers');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endedAt');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByHistoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'historyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByIncorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incorrectAnswers');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByItemsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemsReviewed');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByQuestId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctBySessionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }

  QueryBuilder<UserProgressHistory, UserProgressHistory, QDistinct>
      distinctByXpEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xpEarned');
    });
  }
}

extension UserProgressHistoryQueryProperty
    on QueryBuilder<UserProgressHistory, UserProgressHistory, QQueryProperty> {
  QueryBuilder<UserProgressHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserProgressHistory, int, QQueryOperations>
      correctAnswersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswers');
    });
  }

  QueryBuilder<UserProgressHistory, int, QQueryOperations>
      durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<UserProgressHistory, DateTime, QQueryOperations>
      endedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endedAt');
    });
  }

  QueryBuilder<UserProgressHistory, String, QQueryOperations>
      historyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'historyId');
    });
  }

  QueryBuilder<UserProgressHistory, int, QQueryOperations>
      incorrectAnswersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incorrectAnswers');
    });
  }

  QueryBuilder<UserProgressHistory, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<UserProgressHistory, int, QQueryOperations>
      itemsReviewedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemsReviewed');
    });
  }

  QueryBuilder<UserProgressHistory, double, QQueryOperations>
      progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<UserProgressHistory, String, QQueryOperations>
      questIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questId');
    });
  }

  QueryBuilder<UserProgressHistory, String, QQueryOperations>
      sessionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionType');
    });
  }

  QueryBuilder<UserProgressHistory, DateTime, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }

  QueryBuilder<UserProgressHistory, int, QQueryOperations> xpEarnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xpEarned');
    });
  }
}
