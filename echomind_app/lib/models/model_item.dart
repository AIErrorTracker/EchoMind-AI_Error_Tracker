import 'package:json_annotation/json_annotation.dart';

part 'model_item.g.dart';

@JsonSerializable()
class ModelItem {
  final String id;
  final String name;
  final String? description;

  const ModelItem({required this.id, required this.name, this.description});

  factory ModelItem.fromJson(Map<String, dynamic> json) =>
      _$ModelItemFromJson(json);
}

@JsonSerializable()
class ModelSectionNode {
  final String section;
  final List<ModelItem> items;

  const ModelSectionNode({required this.section, required this.items});

  factory ModelSectionNode.fromJson(Map<String, dynamic> json) =>
      _$ModelSectionNodeFromJson(json);
}

@JsonSerializable()
class ModelChapterNode {
  final String chapter;
  final List<ModelSectionNode> sections;

  const ModelChapterNode({required this.chapter, required this.sections});

  factory ModelChapterNode.fromJson(Map<String, dynamic> json) =>
      _$ModelChapterNodeFromJson(json);
}

@JsonSerializable()
class ModelDetail {
  final String id;
  final String name;
  final String? description;
  final String chapter;
  final String section;
  @JsonKey(name: 'prerequisite_kp_ids')
  final List<String>? prerequisiteKpIds;
  @JsonKey(name: 'confusion_group_ids')
  final List<String>? confusionGroupIds;
  @JsonKey(name: 'mastery_level')
  final int? masteryLevel;
  @JsonKey(name: 'mastery_value')
  final double? masteryValue;
  @JsonKey(name: 'error_count')
  final int errorCount;
  @JsonKey(name: 'correct_count')
  final int correctCount;

  const ModelDetail({
    required this.id,
    required this.name,
    this.description,
    required this.chapter,
    required this.section,
    this.prerequisiteKpIds,
    this.confusionGroupIds,
    this.masteryLevel,
    this.masteryValue,
    this.errorCount = 0,
    this.correctCount = 0,
  });

  factory ModelDetail.fromJson(Map<String, dynamic> json) =>
      _$ModelDetailFromJson(json);
}
