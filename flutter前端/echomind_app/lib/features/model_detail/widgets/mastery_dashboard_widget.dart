import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';

class MasteryDashboardWidget extends StatelessWidget {
  const MasteryDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _funnelCard(),
          const SizedBox(height: 12),
          _trainButton(context),
        ],
      ),
    );
  }

  Widget _funnelCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        children: [
          const Text('当前掌握度',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 4),
          const Text('L1',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppTheme.danger)),
          const Text('建模卡住',
              style: TextStyle(fontSize: 15, color: AppTheme.textSecondary)),
          const SizedBox(height: 2),
          const Text('看到题不确定该用什么方法',
              style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          const SizedBox(height: 18),
          _buildFunnelLayers(),
          const SizedBox(height: 14),
          _buildPredictionCard(),
        ],
      ),
    );
  }

  static Widget _buildFunnelLayers() {
    return Column(
      children: [
        _funnelBar('建模层 · 卡住', 'L1', 1.0, true),
        const SizedBox(height: 6),
        _funnelBar('列式层 · 未到达', 'L2', 0.85, false),
        const SizedBox(height: 6),
        _funnelBar('执行层 · 未到达', 'L3', 0.7, false),
        const SizedBox(height: 6),
        _funnelBar('稳定层 · 未到达', 'L4-5', 0.55, false),
      ],
    );
  }

  static Widget _funnelBar(String label, String level, double widthFrac, bool stuck) {
    final barColor = stuck ? const Color(0xFFFF6B6B) : const Color(0xFFE5E5EA);
    final textColor = stuck ? Colors.white : AppTheme.textSecondary;
    final barFlex = (widthFrac * 100).toInt();
    return Row(
      children: [
        Expanded(
          flex: barFlex,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
          ),
        ),
        Expanded(flex: 100 - barFlex, child: const SizedBox()),
        const SizedBox(width: 8),
        SizedBox(width: 32, child: Text(level, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w500))),
      ],
    );
  }

  static Widget _buildPredictionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: const Column(
        children: [
          Text('解决后预计', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
          SizedBox(height: 2),
          Text('+5 分', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.accent)),
          SizedBox(height: 2),
          Text('关联大题第1题 (12分)', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _trainButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: () => context.push(AppRoutes.modelTraining),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          elevation: 0,
        ),
        child: const Text('开始训练 · 从 Step 1 开始',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}