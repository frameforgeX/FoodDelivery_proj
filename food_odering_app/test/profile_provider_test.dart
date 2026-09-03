import 'package:flutter_test/flutter_test.dart';
import 'package:food_odering_app/data/mock/mock_user.dart';
import 'package:food_odering_app/features/profile/providers/profile_provider.dart';

void main() {
  group('userProfileProvider', () {
    test('updates the displayed name when the profile name is changed', () {
      final notifier = UserProfileNotifier();
      notifier.state = mockUserProfile;

      notifier.updateName('Jane Doe');

      expect(notifier.state?.name, 'Jane Doe');
    });
  });
}
