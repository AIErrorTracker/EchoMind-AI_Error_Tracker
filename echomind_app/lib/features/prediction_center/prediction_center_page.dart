import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/prediction_center/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/score_card_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/trend_card_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/score_path_table_widget.dart';
import 'package:echomind_app/features/prediction_center/widgets/priority_model_list_widget.dart';

class PredictionCenterPage extends StatelessWidget {
  const PredictionCenterPage({super.key});

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
                  ScoreCardWidget(),
                  SizedBox(height: 16),
                  TrendCardWidget(),
                  SizedBox(height: 20),
                  ScorePathTableWidget(),
                  SizedBox(height: 20),
                  PriorityModelListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
