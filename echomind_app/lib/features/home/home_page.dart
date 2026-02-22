import 'package:flutter/material.dart';
import 'package:echomind_app/shared/widgets/page_shell.dart';
import 'package:echomind_app/features/home/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/home/widgets/top_dashboard_widget.dart';
import 'package:echomind_app/features/home/widgets/recommendation_list_widget.dart';
import 'package:echomind_app/features/home/widgets/recent_upload_widget.dart';
import 'package:echomind_app/features/home/widgets/action_overlay_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      tabIndex: 0,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: const [
                TopFrameWidget(title: '主页'),
                SizedBox(height: 4),
                TopDashboardWidget(),
                SizedBox(height: 20),
                RecommendationListWidget(),
                SizedBox(height: 16),
                RecentUploadWidget(),
              ],
            ),
          ),
          const ActionOverlayWidget(),
        ],
      ),
    );
  }
}
