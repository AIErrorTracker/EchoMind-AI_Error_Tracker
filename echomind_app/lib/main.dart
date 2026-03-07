import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/app/app_router.dart';
import 'package:echomind_app/core/api_client.dart';
import 'package:echomind_app/shared/theme/app_theme.dart';

void main() => runApp(const ProviderScope(child: EchoMindApp()));

class EchoMindApp extends StatelessWidget {
  const EchoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EchoMind',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const _ApiErrorOverlay(),
          ],
        );
      },
    );
  }
}

class _ApiErrorOverlay extends StatelessWidget {
  const _ApiErrorOverlay();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: ApiClient.latestError,
      builder: (context, message, _) {
        if (message == null || message.trim().isEmpty) {
          return const SizedBox.shrink();
        }
        return IgnorePointer(
          ignoring: false,
          child: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.error_outline,
                        size: 18,
                        color: Color(0xFFB91C1C),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message,
                        style: AppTheme.body(
                          size: 12,
                          weight: FontWeight.w600,
                          color: const Color(0xFF7F1D1D),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ApiClient.latestError.value = null,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xFF7F1D1D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
