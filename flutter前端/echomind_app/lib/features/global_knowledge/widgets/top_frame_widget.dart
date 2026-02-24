import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class TopFrameWidget extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChanged;
  const TopFrameWidget({super.key, required this.activeTab, required this.onTabChanged});

  static const _tabs = ['知识点', '模型/方法', '高考卷子'];
  static const _routes = [null, AppRoutes.globalModel, AppRoutes.globalExam];

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
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                for (var i = 0; i < _tabs.length; i++) ...[
                  if (i > 0) const SizedBox(width: 4),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_routes[i] != null) {
                          context.go(_routes[i]!);
                        } else {
                          onTabChanged(i);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: i == activeTab ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: i == activeTab
                              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 1))]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _tabs[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: i == activeTab ? FontWeight.w600 : FontWeight.w500,
                            color: i == activeTab ? AppTheme.textPrimary : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
