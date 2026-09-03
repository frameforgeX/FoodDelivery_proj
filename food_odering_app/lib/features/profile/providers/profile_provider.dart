import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_odering_app/models/user_profile.dart';
import 'package:food_odering_app/data/mock/mock_user.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(mockUserProfile);

  void updateName(String name) {
    if (state == null) return;
    state = state!.copyWith(name: name.trim());
  }

  void updateEmail(String email) {
    if (state == null) return;
    state = state!.copyWith(email: email.trim());
  }

  void updatePhone(String phone) {
    if (state == null) return;
    state = state!.copyWith(phone: phone.trim());
  }

  void updateProfileImage(String? imagePath) {
    if (state == null) return;
    state = state!.copyWith(profileImage: imagePath);
  }

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) {
    if (state == null) return;

    state = state!.copyWith(
      name: name?.trim() ?? state!.name,
      email: email?.trim() ?? state!.email,
      phone: phone?.trim() ?? state!.phone,
      profileImage: profileImage ?? state!.profileImage,
    );
  }
}

/// Provider for user profile
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier();
});

/// Provider for user favorites (food IDs)
class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggleFavorite(String foodId) {
    if (state.contains(foodId)) {
      state = {...state}..remove(foodId);
    } else {
      state = {...state, foodId};
    }
  }

  void addFavorite(String foodId) {
    state = {...state, foodId};
  }

  void removeFavorite(String foodId) {
    state = {...state}..remove(foodId);
  }

  bool isFavorite(String foodId) {
    return state.contains(foodId);
  }
}

/// Provider for favorites
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});
