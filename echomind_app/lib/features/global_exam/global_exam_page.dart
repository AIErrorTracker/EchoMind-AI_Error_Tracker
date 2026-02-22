import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/global_exam/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/global_exam/widgets/exam_heatmap_widget.dart';
import 'package:echomind_app/features/global_exam/widgets/question_type_browser_widget.dart';
import 'package:echomind_app/features/global_exam/widgets/recent_exams_widget.dart';

class GlobalExamPage extends StatelessWidget {
  const GlobalExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: const [
            TopFrameWidget(),
            ExamHeatmapWidget(),
            SizedBox(height: 16),
            QuestionTypeBrowserWidget(),
            SizedBox(height: 16),
            RecentExamsWidget(),
          ],
        ),
      ),
    );
  }
}
