import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopFrameWidget extends StatelessWidget {
  const TopFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 16, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          const Text('周复盘', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const Spacer(),
          const Text('第6周', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
        ],
      ),
    );
  }
}
