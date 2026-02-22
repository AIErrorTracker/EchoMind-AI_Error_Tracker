// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgePointItem _$KnowledgePointItemFromJson(Map<String, dynamic> json) =>
    KnowledgePointItem(
      id: json['id'] as String,
      name: json['name'] as String,
      conclusionLevel: (json['conclusion_level'] as num).toInt(),
      description: json['description'] as String?,
    );

SectionNode _$SectionNodeFromJson(Map<String, dynamic> json) => SectionNode(
      section: json['section'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => KnowledgePointItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ChapterNode _$ChapterNodeFromJson(Map<String, dynamic> json) => ChapterNode(
      chapter: json['chapter'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => SectionNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

KnowledgePointDetail _$KnowledgePointDetailFromJson(
        Map<String, dynamic> json) =>
    KnowledgePointDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      conclusionLevel: (json['conclusion_level'] as num).toInt(),
      description: json['description'] as String?,
      chapter: json['chapter'] as String,
      section: json['section'] as String,
      relatedModelIds: (json['related_model_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      masteryLevel: (json['mastery_level'] as num?)?.toInt(),
      masteryValue: (json['mastery_value'] as num?)?.toDouble(),
      errorCount: (json['error_count'] as num?)?.toInt() ?? 0,
      correctCount: (json['correct_count'] as num?)?.toInt() ?? 0,
    );
