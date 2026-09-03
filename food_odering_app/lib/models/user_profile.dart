/// User profile model
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final List<String> savedAddresses;
  final List<String> savedPaymentMethods;
  final DateTime createdAt;
  final bool emailVerified;
  final bool phoneVerified;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.savedAddresses = const [],
    this.savedPaymentMethods = const [],
    DateTime? createdAt,
    this.emailVerified = false,
    this.phoneVerified = false,
  }) : createdAt = createdAt ?? DateTime.now();

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    List<String>? savedAddresses,
    List<String>? savedPaymentMethods,
    DateTime? createdAt,
    bool? emailVerified,
    bool? phoneVerified,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      savedPaymentMethods: savedPaymentMethods ?? this.savedPaymentMethods,
      createdAt: createdAt ?? this.createdAt,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
    );
  }

  @override
  String toString() => 'UserProfile(id: $id, name: $name, email: $email)';
}
