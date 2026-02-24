import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class TopFrameWidget extends StatelessWidget {
  const TopFrameWidget({super.key});

  static const _tabs = ['知识点', '模型/方法', '高考卷子'];
  static const _routes = [AppRoutes.globalKnowledge, AppRoutes.globalModel, null];
  static const _activeIndex = 2;

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
                      onTap: _routes[i] != null ? () => context.go(_routes[i]!) : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: i == _activeIndex ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: i == _activeIndex
                              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 1))]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _tabs[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: i == _activeIndex ? FontWeight.w600 : FontWeight.w500,
                            color: i == _activeIndex ? AppTheme.textPrimary : AppTheme.textSecondary,
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
