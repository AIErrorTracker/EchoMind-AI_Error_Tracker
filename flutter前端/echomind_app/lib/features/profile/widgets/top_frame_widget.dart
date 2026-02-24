import 'package:flutter/material.dart';

class TopFrameWidget extends StatelessWidget {
  const TopFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text('我的', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
    );
  }
}
