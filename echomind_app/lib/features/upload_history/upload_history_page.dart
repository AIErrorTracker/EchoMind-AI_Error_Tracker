import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';
import 'package:echomind_app/providers/upload_history_provider.dart';
import 'package:echomind_app/features/upload_history/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_filter_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_date_scroll_widget.dart';
import 'package:echomind_app/features/upload_history/widgets/history_record_list_widget.dart';

class UploadHistoryPage extends ConsumerWidget {
  const UploadHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 预取数据，子组件可直接使用
    ref.watch(uploadHistoryProvider);
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: const SafeArea(
        child: Column(
          children: [
            TopFrameWidget(),
            HistoryFilterWidget(),
            SizedBox(height: 10),
            HistoryDateScrollWidget(),
            SizedBox(height: 10),
            Expanded(child: HistoryRecordListWidget()),
          ],
        ),
      ),
    );
  }
}
