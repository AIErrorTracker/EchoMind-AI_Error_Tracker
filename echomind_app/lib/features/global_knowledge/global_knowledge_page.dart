import 'package:flutter/material.dart';
import 'package:echomind_app/shared/widgets/page_shell.dart';
import 'package:echomind_app/features/global_knowledge/widgets/top_frame_widget.dart';
import 'package:echomind_app/features/global_knowledge/widgets/knowledge_tree_widget.dart';

class GlobalKnowledgePage extends StatelessWidget {
  const GlobalKnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      tabIndex: 1,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          TopFrameWidget(activeTab: 0, onTabChanged: (_) {}),
          const KnowledgeTreeWidget(),
        ],
      ),
    );
  }
}
