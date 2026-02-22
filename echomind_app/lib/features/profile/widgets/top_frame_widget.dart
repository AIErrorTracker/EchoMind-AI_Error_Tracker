import 'package:flutter/material.dart';

class TopFrameWidget extends StatelessWidget {
  const TopFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text('我的', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    );
  }
}
