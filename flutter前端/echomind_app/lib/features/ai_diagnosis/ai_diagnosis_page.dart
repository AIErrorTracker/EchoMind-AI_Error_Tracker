import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/ai_diagnosis/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/ai_diagnosis/widgets/main_content_widget.dart';
import 'package:echomind_app/features/ai_diagnosis/widgets/action_overlay_widget.dart';

class AiDiagnosisPage extends StatelessWidget {
  const AiDiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: const SafeArea(
        child: Column(
          children: [
            TopFrameWidget(),
            Expanded(child: MainContentWidget()),
            ActionOverlayWidget(),
          ],
        ),
      ),
    );
  }
}
