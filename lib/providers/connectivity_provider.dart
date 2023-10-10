import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityState {
  ConnectivityStatus status = ConnectivityStatus.online;
}

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityState>((ref) {
  return ConnectivityNotifier();
});

final isOfflineProvider = Provider<bool>((ref) {
  final connectivityStatus = ref.watch(connectivityProvider);
  return connectivityStatus.status == ConnectivityStatus.offline;
});

class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  ConnectivityNotifier() : super(ConnectivityState()) {
    Connectivity().onConnectivityChanged.listen((result) {
      state = ConnectivityState()
        ..status = result == ConnectivityResult.none
            ? ConnectivityStatus.offline
            : ConnectivityStatus.online;
    });
  }
}
