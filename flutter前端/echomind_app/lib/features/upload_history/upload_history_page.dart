import 'package:flutter/material.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/features/upload_history/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_filter_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_record_list_widget.dart';

class UploadHistoryPage extends StatelessWidget {
  const UploadHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: const SafeArea(
        child: Column(
          children: [
            TopFrameWidget(),
            HistoryFilterWidget(),
            SizedBox(height: 10),
            Expanded(child: HistoryRecordListWidget()),
          ],
        ),
      ),
    );
  }
}
