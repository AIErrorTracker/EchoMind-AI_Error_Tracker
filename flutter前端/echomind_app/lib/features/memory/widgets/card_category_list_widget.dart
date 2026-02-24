import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

class CardCategoryListWidget extends StatelessWidget {
  const CardCategoryListWidget({super.key});

  static const _categories = [
    (tag: '识别', tagBg: Color(0xFF1C1C1E), tagFg: Colors.white, name: '识别卡', desc: '8张 · 来自模型训练 Step1', review: '3张待复习'),
    (tag: '决策', tagBg: Color(0xFF48484A), tagFg: Colors.white, name: '决策卡', desc: '6张 · 来自模型训练 Step2', review: '2张待复习'),
    (tag: '步骤', tagBg: Color(0xFF8E8E93), tagFg: Colors.white, name: '步骤卡', desc: '5张 · 来自模型训练 Step3', review: '1张待复习'),
    (tag: '陷阱', tagBg: Color(0xFF3A3A3C), tagFg: Colors.white, name: '陷阱卡', desc: '4张 · 来自模型训练 Step4', review: '0'),
    (tag: '公式', tagBg: Color(0xFF007AFF), tagFg: Colors.white, name: '公式卡', desc: '10张 · 通用', review: '4张待复习'),
    (tag: '概念', tagBg: Color(0xFFBBDEFB), tagFg: Color(0xFF1565C0), name: '概念卡', desc: '9张 · 来自知识点学习', review: '2张待复习'),
    (tag: '条件', tagBg: Color(0xFFE3F2FD), tagFg: Color(0xFF1976D2), name: '条件卡', desc: '4张 · 来自知识点学习', review: '0'),
    (tag: '辨析', tagBg: Color(0xFFF5F9FF), tagFg: Color(0xFF2196F3), name: '辨析卡', desc: '2张 · 来自易混对比', review: '0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('卡片分类', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('管理', style: TextStyle(fontSize: 14, color: AppTheme.primary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              children: [
                for (var i = 0; i < _categories.length; i++) ...[
                  if (i > 0) const Divider(height: 1, indent: 56, endIndent: 0, color: AppTheme.divider),
                  _CategoryRow(c: _categories[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final dynamic c;
  const _CategoryRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: c.tagBg as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              c.tag as String,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.tagFg as Color),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.name as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(c.desc as String, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ),
          Text(
            c.review as String,
            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
