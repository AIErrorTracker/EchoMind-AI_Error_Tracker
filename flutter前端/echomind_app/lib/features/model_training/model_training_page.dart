import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/model_training/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/model_training/widgets/step_stage_nav_widget.dart';
import 'package:echomind_app/features/model_training/widgets/step1_identification_training_widget.dart';
import 'package:echomind_app/features/model_training/widgets/training_dialogue_widget.dart';
import 'package:echomind_app/features/model_training/widgets/action_overlay_widget.dart';

class ModelTrainingPage extends StatefulWidget {
  const ModelTrainingPage({super.key});

  @override
  State<ModelTrainingPage> createState() => _ModelTrainingPageState();
}

class _ModelTrainingPageState extends State<ModelTrainingPage> {
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
            Step1IdentificationTrainingWidget(stepIndex: _currentStep),
            const Expanded(child: TrainingDialogueWidget()),
            const ActionOverlayWidget(),
          ],
        ),
      ),
    );
  }
}
