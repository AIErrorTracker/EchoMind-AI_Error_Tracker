import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/core/api_client.dart';

class WeeklyReviewData {
  final int questionCount;
  final double correctRate;
  final int trainingCount;
  final double studyHours;
  final double lastWeekScore;
  final double thisWeekScore;
  final List<String> progressItems;
  final List<String> focusItems;

  const WeeklyReviewData({
    this.questionCount = 0,
    this.correctRate = 0,
    this.trainingCount = 0,
    this.studyHours = 0,
    this.lastWeekScore = 0,
    this.thisWeekScore = 0,
    this.progressItems = const [],
    this.focusItems = const [],
  });

  factory WeeklyReviewData.fromJson(Map<String, dynamic> json) => WeeklyReviewData(
        questionCount: json['question_count'] ?? 0,
        correctRate: (json['correct_rate'] as num?)?.toDouble() ?? 0,
        trainingCount: json['training_count'] ?? 0,
        studyHours: (json['study_hours'] as num?)?.toDouble() ?? 0,
        lastWeekScore: (json['last_week_score'] as num?)?.toDouble() ?? 0,
        thisWeekScore: (json['this_week_score'] as num?)?.toDouble() ?? 0,
        progressItems: (json['progress_items'] as List?)?.cast<String>() ?? [],
        focusItems: (json['focus_items'] as List?)?.cast<String>() ?? [],
      );
}

final weeklyReviewProvider = FutureProvider<WeeklyReviewData>((ref) async {
  try {
    final res = await ApiClient().dio.get('/weekly-review');
    return WeeklyReviewData.fromJson(res.data);
  } catch (_) {
    // API 尚未实现时返回默认数据
    return const WeeklyReviewData();
  }
});
