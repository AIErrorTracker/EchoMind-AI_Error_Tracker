import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/model_detail/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/mastery_dashboard_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/prerequisite_knowledge_list_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/related_question_list_widget.dart';
import 'package:echomind_app/features/model_detail/widgets/training_record_list_widget.dart';

class ModelDetailPage extends StatelessWidget {
  final String modelId;
  const ModelDetailPage({super.key, required this.modelId});

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
                  MasteryDashboardWidget(modelId: modelId),
                  SizedBox(height: 20),
                  PrerequisiteKnowledgeListWidget(modelId: modelId),
                  SizedBox(height: 20),
                  RelatedQuestionListWidget(),
                  SizedBox(height: 20),
                  TrainingRecordListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
