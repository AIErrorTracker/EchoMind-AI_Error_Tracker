// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelItem _$ModelItemFromJson(Map<String, dynamic> json) => ModelItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

ModelSectionNode _$ModelSectionNodeFromJson(Map<String, dynamic> json) =>
    ModelSectionNode(
      section: json['section'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ModelItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModelChapterNode _$ModelChapterNodeFromJson(Map<String, dynamic> json) =>
    ModelChapterNode(
      chapter: json['chapter'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => ModelSectionNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ModelDetail _$ModelDetailFromJson(Map<String, dynamic> json) => ModelDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      chapter: json['chapter'] as String,
      section: json['section'] as String,
      prerequisiteKpIds: (json['prerequisite_kp_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      confusionGroupIds: (json['confusion_group_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      masteryLevel: (json['mastery_level'] as num?)?.toInt(),
      masteryValue: (json['mastery_value'] as num?)?.toDouble(),
      errorCount: (json['error_count'] as num?)?.toInt() ?? 0,
      correctCount: (json['correct_count'] as num?)?.toInt() ?? 0,
    );
