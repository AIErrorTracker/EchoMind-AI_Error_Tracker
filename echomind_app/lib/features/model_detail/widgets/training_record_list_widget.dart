import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/model_detail_provider.dart';

class TrainingRecordListWidget extends ConsumerWidget {
  final String modelId;
  const TrainingRecordListWidget({super.key, required this.modelId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(modelDetailProvider(modelId));

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
              const Text('训练记录', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
                        const Text('总训练次数', style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('正确率 $rate', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                      ]),
                    ),
                    Text('$total 次', style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
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
