import 'package:flutter/material.dart';
import 'package:echomind_app/shared/widgets/page_shell.dart';
import 'package:echomind_app/features/profile/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/profile/widgets/user_info_card_widget.dart';
import 'package:echomind_app/features/profile/widgets/target_score_card_widget.dart';
import 'package:echomind_app/features/profile/widgets/learning_stats_widget.dart';
import 'package:echomind_app/features/profile/widgets/three_row_navigation_widget.dart';
import 'package:echomind_app/features/profile/widgets/two_row_navigation_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      tabIndex: 4,
      body: ListView(
        padding: EdgeInsets.only(bottom: 24),
        children: [
          TopFrameWidget(),
          SizedBox(height: 8),
          UserInfoCardWidget(),
          SizedBox(height: 12),
          TargetScoreCardWidget(),
          SizedBox(height: 12),
          LearningStatsWidget(),
          SizedBox(height: 12),
          ThreeRowNavigationWidget(),
          SizedBox(height: 12),
          TwoRowNavigationWidget(),
        ],
      ),
    );
  }
}
