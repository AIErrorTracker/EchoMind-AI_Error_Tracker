import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/knowledge_detail_provider.dart';

class RelatedModelsWidget extends ConsumerWidget {
  final String kpId;
  const RelatedModelsWidget({super.key, required this.kpId});

  static const _mockItems = [
    (id: 'mock', name: '受力分析'),
    (id: 'mock', name: '电场叠加'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(knowledgeDetailProvider(kpId));

    final ids = detail.whenOrNull(
      data: (d) => d.relatedModelIds,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('关联模型', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          if (ids != null && ids.isNotEmpty)
            for (var i = 0; i < ids.length; i++)
              _item(context, ids[i], ids[i], i < ids.length - 1)
          else
            for (var i = 0; i < _mockItems.length; i++)
              _item(context, _mockItems[i].id, _mockItems[i].name, i < _mockItems.length - 1),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String id, String name, bool hasMargin) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.modelDetailPath(id)),
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
