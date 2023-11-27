import 'package:audiory_v0/models/Profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlobalMeNotifier extends Notifier<Profile?> {
  @override
  Profile? build() {
    return null;
  }

  setUser(Profile? profile) {
    state = profile;
  }
}

final globalMeProvider = NotifierProvider<GlobalMeNotifier, Profile?>(() {
  return GlobalMeNotifier();
});
