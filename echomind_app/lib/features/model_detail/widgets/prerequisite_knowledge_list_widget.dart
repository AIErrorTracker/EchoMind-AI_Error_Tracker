import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/model_detail_provider.dart';

class PrerequisiteKnowledgeListWidget extends ConsumerWidget {
  final String modelId;
  const PrerequisiteKnowledgeListWidget({super.key, required this.modelId});

  static const _mockItems = ['牛顿第三定律', '力的合成与分解', '摩擦力分类'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(modelDetailProvider(modelId));

    final ids = detail.whenOrNull(
      data: (d) => d.prerequisiteKpIds,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('前置知识点', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          if (ids != null && ids.isNotEmpty)
            for (var i = 0; i < ids.length; i++)
              _item(context, ids[i], ids[i], i < ids.length - 1)
          else
            for (var i = 0; i < _mockItems.length; i++)
              _item(context, 'mock', _mockItems[i], i < _mockItems.length - 1),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String id, String name, bool hasMargin) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.knowledgeDetailPath(id)),
      child: Container(
        margin: EdgeInsets.only(bottom: hasMargin ? 8 : 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Row(children: [
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14))),
          const Icon(Icons.chevron_right, size: 18, color: AppTheme.textSecondary),
        ]),
      ),
    );
  }
}
