import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:echomind_app/app/app_routes.dart';
import 'package:echomind_app/providers/dashboard_provider.dart';

class TopDashboardWidget extends ConsumerWidget {
  const TopDashboardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);

    return dashboard.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => _buildContent(context, const DashboardData()),
      data: (data) => _buildContent(context, data),
    );
  }

  Widget _buildContent(BuildContext context, DashboardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _StatsRow(data: data),
          const SizedBox(height: 12),
          _PredictionCard(data: data, onTap: () => context.push(AppRoutes.predictionCenter)),
          const SizedBox(height: 12),
          _AbilityRadar(data: data),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final DashboardData data;
  const _StatsRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('${data.totalQuestions}', '总题数'),
      ('${data.errorCount}', '错题数'),
      ('${data.masteryCount}', '已掌握'),
      ('${data.weakCount}', '薄弱点'),
    ];
    return Row(
      children: [
        for (var i = 0; i < stats.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: _StatCard(value: stats[i].$1, label: stats[i].$2)),
        ],
      ],
    );
  }
}

class _PredictionCard extends StatelessWidget {
  final DashboardData data;
  final VoidCallback onTap;
  const _PredictionCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final score = data.predictedScore?.round() ?? 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        child: Row(children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('预测分数', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('$score', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()])),
                  const SizedBox(width: 4),
                  const Text('/ 100', style: TextStyle(fontSize: 15, color: AppTheme.textSecondary)),
                ],
              ),
              Text('查看预测详情 →', style: TextStyle(fontSize: 13, color: AppTheme.accent, fontWeight: FontWeight.w500)),
            ],
          )),
        ]),
      ),
    );
  }
}

class _AbilityRadar extends StatelessWidget {
  final DashboardData data;
  const _AbilityRadar({required this.data});

  @override
  Widget build(BuildContext context) {
    final abilities = [
      ('公式记忆', data.formulaMemoryRate),
      ('模型识别', data.modelIdentifyRate),
      ('计算准确', data.calculationAccuracy),
      ('审题准确', data.readingAccuracy),
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Row(
        children: [
          for (var i = 0; i < abilities.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(child: _AbilityItem(label: abilities[i].$1, rate: abilities[i].$2)),
          ],
        ],
      ),
    );
  }
}

class _AbilityItem extends StatelessWidget {
  final String label;
  final double rate;
  const _AbilityItem({required this.label, required this.rate});

  @override
  Widget build(BuildContext context) {
    final pct = (rate * 100).round();
    return Column(children: [
      Text('$pct%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()])),
      const SizedBox(height: 4),
      ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(value: rate, minHeight: 4, backgroundColor: AppTheme.background, color: AppTheme.primary),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
      child: Column(children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()])),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ]),
    );
  }
}
