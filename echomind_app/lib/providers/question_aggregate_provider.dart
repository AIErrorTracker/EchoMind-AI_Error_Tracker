import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/core/api_client.dart';

class QuestionAggregateData {
  final int attemptCount;
  final double correctRate;
  final int predictedScore;
  final String errorTendency;
  final String weakPoints;
  final String suggestion;
  final List<QuestionHistoryItem> history;

  const QuestionAggregateData({
    this.attemptCount = 0,
    this.correctRate = 0,
    this.predictedScore = 0,
    this.errorTendency = '',
    this.weakPoints = '',
    this.suggestion = '',
    this.history = const [],
  });

  factory QuestionAggregateData.fromJson(Map<String, dynamic> json) =>
      QuestionAggregateData(
        attemptCount: json['attempt_count'] ?? 0,
        correctRate: (json['correct_rate'] as num?)?.toDouble() ?? 0,
        predictedScore: json['predicted_score'] ?? 0,
        errorTendency: json['error_tendency'] ?? '',
        weakPoints: json['weak_points'] ?? '',
        suggestion: json['suggestion'] ?? '',
        history: (json['history'] as List?)
                ?.map((e) => QuestionHistoryItem.fromJson(e))
                .toList() ??
            [],
      );
}

class QuestionHistoryItem {
  final String exam;
  final String date;
  final String result;
  final String score;
  final String? questionId;

  const QuestionHistoryItem({
    this.exam = '',
    this.date = '',
    this.result = '',
    this.score = '',
    this.questionId,
  });

  factory QuestionHistoryItem.fromJson(Map<String, dynamic> json) =>
      QuestionHistoryItem(
        exam: json['exam'] ?? '',
        date: json['date'] ?? '',
        result: json['result'] ?? '',
        score: json['score'] ?? '',
        questionId: json['question_id'],
      );
}

final questionAggregateProvider =
    FutureProvider<QuestionAggregateData>((ref) async {
  try {
    final res = await ApiClient().dio.get('/questions/aggregate');
    return QuestionAggregateData.fromJson(res.data);
  } catch (_) {
    return const QuestionAggregateData();
  }
});
