import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/weekly_review/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/weekly_dashboard_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/score_change_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/weekly_progress_widget.dart';
import 'package:echomind_app/features/weekly_review/widgets/next_week_focus_widget.dart';

class WeeklyReviewPage extends StatelessWidget {
  const WeeklyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            TopFrameWidget(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 24),
                children: [
                  WeeklyDashboardWidget(),
                  SizedBox(height: 16),
                  ScoreChangeWidget(),
                  SizedBox(height: 20),
                  WeeklyProgressWidget(),
                  SizedBox(height: 20),
                  NextWeekFocusWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
