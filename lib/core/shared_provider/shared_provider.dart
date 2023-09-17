import 'package:audiory_v0/core/network/constant/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audiory_v0/core/network/dio_client.dart';
import 'package:audiory_v0/core/shared_preferences/helper.dart';
import 'package:audiory_v0/core/shared_preferences/preferences.dart';

import '../network/dio_client.dart';

final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio();
});

final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioInstanceProvider);
  return DioClient(dio);
});

final preferencesProvider = Provider<Preference>((ref) {
  return Preference();
});

final sharedPrefHelperProvider = Provider<SharedPreferenceHelper>((ref) {
  return SharedPreferenceHelper(ref.read(preferencesProvider));
});
