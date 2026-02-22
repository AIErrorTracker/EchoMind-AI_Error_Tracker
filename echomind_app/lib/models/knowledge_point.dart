import 'package:json_annotation/json_annotation.dart';

part 'knowledge_point.g.dart';

@JsonSerializable()
class KnowledgePointItem {
  final String id;
  final String name;
  @JsonKey(name: 'conclusion_level')
  final int conclusionLevel;
  final String? description;

  const KnowledgePointItem({
    required this.id,
    required this.name,
    required this.conclusionLevel,
    this.description,
  });

  factory KnowledgePointItem.fromJson(Map<String, dynamic> json) =>
      _$KnowledgePointItemFromJson(json);
}

@JsonSerializable()
class SectionNode {
  final String section;
  final List<KnowledgePointItem> items;

  const SectionNode({required this.section, required this.items});

  factory SectionNode.fromJson(Map<String, dynamic> json) =>
      _$SectionNodeFromJson(json);
}

@JsonSerializable()
class ChapterNode {
  final String chapter;
  final List<SectionNode> sections;

  const ChapterNode({required this.chapter, required this.sections});

  factory ChapterNode.fromJson(Map<String, dynamic> json) =>
      _$ChapterNodeFromJson(json);
}

@JsonSerializable()
class KnowledgePointDetail {
  final String id;
  final String name;
  @JsonKey(name: 'conclusion_level')
  final int conclusionLevel;
  final String? description;
  final String chapter;
  final String section;
  @JsonKey(name: 'related_model_ids')
  final List<String>? relatedModelIds;
  @JsonKey(name: 'mastery_level')
  final int? masteryLevel;
  @JsonKey(name: 'mastery_value')
  final double? masteryValue;
  @JsonKey(name: 'error_count')
  final int errorCount;
  @JsonKey(name: 'correct_count')
  final int correctCount;

  const KnowledgePointDetail({
    required this.id,
    required this.name,
    required this.conclusionLevel,
    this.description,
    required this.chapter,
    required this.section,
    this.relatedModelIds,
    this.masteryLevel,
    this.masteryValue,
    this.errorCount = 0,
    this.correctCount = 0,
  });

  factory KnowledgePointDetail.fromJson(Map<String, dynamic> json) =>
      _$KnowledgePointDetailFromJson(json);
}
