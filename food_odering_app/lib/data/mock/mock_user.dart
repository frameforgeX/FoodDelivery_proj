import 'package:food_odering_app/models/user_profile.dart';

/// Mock user profile data
final UserProfile mockUserProfile = UserProfile(
  id: 'user_1',
  name: 'John Doe',
  email: 'john.doe@example.com',
  phone: '+1-555-0100',
  profileImage: 'https://api.dicebear.com/7.x/avataaars/svg?seed=John',
  savedAddresses: [
    '123 Main St, New York, NY 10001',
    '456 Park Ave, New York, NY 10002',
    'Office: 789 Business St, New York, NY 10003',
  ],
  savedPaymentMethods: ['Visa ending in 4242', 'Mastercard ending in 1234'],
  emailVerified: true,
  phoneVerified: true,
);
