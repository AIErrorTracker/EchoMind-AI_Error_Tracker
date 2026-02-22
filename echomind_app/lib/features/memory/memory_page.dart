import 'package:flutter/material.dart';
import 'package:echomind_app/shared/widgets/page_shell.dart';
import 'package:echomind_app/features/memory/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/memory/widgets/review_dashboard_widget.dart';
import 'package:echomind_app/features/memory/widgets/card_category_list_widget.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      tabIndex: 2,
      body: ListView(
        padding: EdgeInsets.only(bottom: 16),
        children: [
          TopFrameWidget(),
          SizedBox(height: 8),
          ReviewDashboardWidget(),
          SizedBox(height: 20),
          CardCategoryListWidget(),
        ],
      ),
    );
  }
}
