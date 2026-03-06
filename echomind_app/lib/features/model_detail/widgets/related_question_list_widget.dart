import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/providers/model_detail_provider.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/shared/widgets/clay_card.dart';

class RelatedQuestionListWidget extends ConsumerWidget {
  final String modelId;

  const RelatedQuestionListWidget({super.key, required this.modelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(modelDetailProvider(modelId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('相关题目',
              style: AppTheme.heading(size: 18, weight: FontWeight.w900)),
          const SizedBox(height: 10),
          async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _statusCard('相关题目加载失败，请检查后端接口与鉴权状态'),
            data: (data) {
              final total = data.errorCount + data.correctCount;
              if (total <= 0) {
                return _statusCard('暂无相关题目统计数据');
              }

              return ClayCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '当前接口仅返回统计值，未返回可跳转的题目 ID 列表。',
                      style: AppTheme.body(size: 13, weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    _statRow('历史错误题', '${data.errorCount}'),
                    const SizedBox(height: 6),
                    _statRow('历史正确题', '${data.correctCount}'),
                  ],
                ),
              );
            },
          ),
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
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: AppTheme.label(size: 12)),
        const Spacer(),
        Text(value, style: AppTheme.body(size: 13, weight: FontWeight.w700)),
      ],
    );
  }
}
