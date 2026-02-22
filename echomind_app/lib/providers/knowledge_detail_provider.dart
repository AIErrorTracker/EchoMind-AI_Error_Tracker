import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/core/api_client.dart';
import 'package:echomind_app/models/knowledge_point.dart';

final knowledgeDetailProvider =
    FutureProvider.family<KnowledgePointDetail, String>((ref, kpId) async {
  final res = await ApiClient().dio.get('/knowledge/$kpId');
  return KnowledgePointDetail.fromJson(res.data);
});
