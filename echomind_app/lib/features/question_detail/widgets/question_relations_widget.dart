import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/question_detail_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class QuestionRelationsWidget extends ConsumerWidget {
  final String questionId;

  const QuestionRelationsWidget({super.key, required this.questionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(questionDetailProvider(questionId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: detail.when(
        loading: () => _statusCard('关联信息加载中...'),
        error: (_, __) => _statusCard('关联信息加载失败，请检查后端接口与鉴权状态'),
        data: (d) {
          final modelName = (d.modelName ?? '').trim();
          final modelId = (d.modelId ?? '').trim();
          final knowledgeNames = _knowledgeNames(d.knowledgePointName);
          final kpId = (d.knowledgePointId ?? '').trim();

          final hasModel = modelName.isNotEmpty;
          final hasKnowledge = knowledgeNames.isNotEmpty;

          if (!hasModel && !hasKnowledge) {
            return _statusCard('暂无关联模型/知识点数据');
          }

          return ClayCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('归属模型', style: AppTheme.label(size: 12)),
                const SizedBox(height: 8),
                if (hasModel)
                  Wrap(
                    spacing: 6,
                    children: [
                      _blueTag(
                        context: context,
                        text: modelName,
                        onTap: modelId.isEmpty
                            ? null
                            : () => context
                                .push(AppRoutes.modelDetailPath(modelId)),
                      ),
                    ],
                  )
                else
                  Text('暂无', style: AppTheme.label(size: 12)),
                const SizedBox(height: 14),
                Text('关联知识点', style: AppTheme.label(size: 12)),
                const SizedBox(height: 8),
                if (hasKnowledge)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final name in knowledgeNames)
                        _grayTag(
                          context: context,
                          text: name,
                          onTap: kpId.isEmpty
                              ? null
                              : () => context
                                  .push(AppRoutes.knowledgeDetailPath(kpId)),
                        ),
                    ],
                  )
                else
                  Text('暂无', style: AppTheme.label(size: 12)),
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

  Widget _blueTag({
    required BuildContext context,
    required String text,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child:
            Text(text, style: AppTheme.label(size: 12, color: AppTheme.accent)),
      ),
    );
  }

  Widget _grayTag({
    required BuildContext context,
    required String text,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.canvas,
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Text(text, style: AppTheme.label(size: 12)),
      ),
    );
  }

  List<String> _knowledgeNames(String? raw) {
    final text = raw?.trim() ?? '';
    if (text.isEmpty) return const [];

    final parts = text
        .split(RegExp(r'[，、|]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return parts.isEmpty ? [text] : parts;
  }
}
