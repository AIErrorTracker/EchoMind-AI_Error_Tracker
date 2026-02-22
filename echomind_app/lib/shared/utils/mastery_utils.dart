import 'package:flutter/material.dart';

class MasteryLevelInfo {
  final String label;
  final Color color;
  const MasteryLevelInfo(this.label, this.color);
}

class MasteryUtils {
  MasteryUtils._();

  static MasteryLevelInfo levelInfo(int level) => switch (level) {
    0 => const MasteryLevelInfo('未学习', Color(0xFFFF3B30)),
    1 => const MasteryLevelInfo('初步接触', Color(0xFFFF9500)),
    2 => const MasteryLevelInfo('初步了解', Color(0xFFFFCC00)),
    3 => const MasteryLevelInfo('基本掌握', Color(0xFF007AFF)),
    4 => const MasteryLevelInfo('熟练掌握', Color(0xFF34C759)),
    _ => const MasteryLevelInfo('完全掌握', Color(0xFF00875A)),
  };
}
