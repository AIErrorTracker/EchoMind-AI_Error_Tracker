import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/core/api_client.dart';
import 'package:echomind_app/models/question.dart';

final uploadHistoryProvider =
    FutureProvider<List<HistoryDateGroup>>((ref) async {
  final res = await ApiClient().dio.get('/questions/history');
  return (res.data as List)
      .map((e) => HistoryDateGroup.fromJson(e))
      .toList();
});
