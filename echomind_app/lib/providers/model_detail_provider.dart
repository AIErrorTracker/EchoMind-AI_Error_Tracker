import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echomind_app/core/api_client.dart';
import 'package:echomind_app/models/model_item.dart';

final modelDetailProvider =
    FutureProvider.family<ModelDetail, String>((ref, modelId) async {
  final res = await ApiClient().dio.get('/models/$modelId');
  return ModelDetail.fromJson(res.data);
});
