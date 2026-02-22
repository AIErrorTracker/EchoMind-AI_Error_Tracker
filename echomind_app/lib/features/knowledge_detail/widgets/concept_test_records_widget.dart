import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/knowledge_detail_provider.dart';

class ConceptTestRecordsWidget extends ConsumerWidget {
  final String kpId;
  const ConceptTestRecordsWidget({super.key, required this.kpId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(knowledgeDetailProvider(kpId));

    return async.when(
      loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) {
        final total = data.errorCount + data.correctCount;
        final rate = total > 0 ? '${(data.correctCount * 100 / total).round()}%' : '-';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('概念检测记录', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('总测试 $total 次', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('正确率 $rate', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      ]),
                    ),
                    Text('错题 ${data.errorCount}', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
