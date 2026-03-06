import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/exam_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class RecentExamsWidget extends ConsumerWidget {
  const RecentExamsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(recentExamsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '最近试卷',
            style: AppTheme.heading(size: 18, weight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          examsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _statusCard('最近试卷加载失败，请检查后端接口与鉴权状态'),
            data: (exams) {
              if (exams.isEmpty) {
                return _statusCard('暂无最近试卷数据');
              }
              return Column(
                children: [
                  for (var i = 0; i < exams.length; i++) ...[
                    if (i > 0) const SizedBox(height: 10),
                    _buildExamCard(context, exams[i]),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, RecentExam exam) {
    return ClayCard(
      onTap: () => context.push(AppRoutes.uploadHistory),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppTheme.gradientPrimary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accent.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam.title,
                  style: AppTheme.body(size: 15, weight: FontWeight.w800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text('${exam.date} · ${exam.count}',
                    style: AppTheme.label(size: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppTheme.muted),
        ],
      ),
    );
  }

  Widget _statusCard(String message) {
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Text(
        message,
        style: AppTheme.body(size: 13, weight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
