import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class TopFrameWidget extends StatelessWidget {
  const TopFrameWidget({super.key});

  static const _tabs = ['知识点', '模型', '考试'];
  static const _routes = [AppRoutes.globalKnowledge, AppRoutes.globalModel, null];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text('全局知识', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (var i = 0; i < _tabs.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                GestureDetector(
                  onTap: _routes[i] != null ? () => context.go(_routes[i]!) : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: i == 2 ? AppTheme.primary : AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: i == 2 ? Colors.white : AppTheme.textSecondary),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
