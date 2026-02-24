import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/step_stage_nav_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/step1_concept_present_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/learning_dialogue_widget.dart';
import 'package:echomind_app/features/knowledge_learning/widgets/action_overlay_widget.dart';

class KnowledgeLearningPage extends StatefulWidget {
  const KnowledgeLearningPage({super.key});

  @override
  State<KnowledgeLearningPage> createState() => _KnowledgeLearningPageState();
}

class _KnowledgeLearningPageState extends State<KnowledgeLearningPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const TopFrameWidget(),
            StepStageNavWidget(
              currentStep: _currentStep,
              onStepChanged: (i) => setState(() => _currentStep = i),
            ),
            Step1ConceptPresentWidget(stepIndex: _currentStep),
            const Expanded(child: LearningDialogueWidget()),
            const ActionOverlayWidget(),
          ],
        ),
      ),
    );
  }
}
