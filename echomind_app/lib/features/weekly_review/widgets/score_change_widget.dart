import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:echomind_app/providers/weekly_review_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class ScoreChangeWidget extends ConsumerWidget {
  const ScoreChangeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(weeklyReviewProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: asyncData.when(
        loading: () => _statusCard('分数变化加载中...'),
        error: (_, __) => _statusCard('分数变化加载失败，请检查后端接口与鉴权状态'),
        data: (api) {
          final data = _ScoreViewData.fromApi(api);
          return ClayCard(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('分数变化',
                    style: AppTheme.heading(size: 22, weight: FontWeight.w900)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _scoreBlock('上周', data.previousScore, null),
                    const SizedBox(width: 18),
                    Text(
                      '→',
                      style: GoogleFonts.nunito(
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.accent,
                      ),
                    ),
                    const SizedBox(width: 18),
                    _scoreBlock('本周', data.currentScore, AppTheme.accent),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statusCard(String message) {
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: AppTheme.body(size: 13, weight: FontWeight.w600),
      ),
    );
  }

  Widget _scoreBlock(String label, String value, Color? color) {
    return Column(
      children: [
        Text(
          label,
          style: AppTheme.body(size: 20, weight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.nunito(
            fontSize: 46,
            fontWeight: FontWeight.w900,
            color: color ?? AppTheme.foreground,
          ),
        ),
      ],
    );
  }
}

class _ScoreViewData {
  final String previousScore;
  final String currentScore;

  const _ScoreViewData({
    required this.previousScore,
    required this.currentScore,
  });

  factory _ScoreViewData.fromApi(WeeklyReviewData data) {
    return _ScoreViewData(
      previousScore: data.lastWeekScore.toInt().toString(),
      currentScore: data.thisWeekScore.toInt().toString(),
    );
  }
}
