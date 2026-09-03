import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/features/onboarding/screens/splash_screen.dart';
import 'package:food_odering_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:food_odering_app/features/authentication/screens/login_screen.dart';
import 'package:food_odering_app/features/authentication/screens/signup_screen.dart';
import 'package:food_odering_app/features/authentication/screens/forgot_password_screen.dart';
import 'package:food_odering_app/features/home/screens/main_screen.dart';
import 'package:food_odering_app/features/menu/screens/menu_screen.dart';
import 'package:food_odering_app/features/search/screens/search_screen.dart';
import 'package:food_odering_app/features/food_details/screens/food_details_screen.dart';
import 'package:food_odering_app/features/favorites/screens/favorites_screen.dart';
import 'package:food_odering_app/features/cart/screens/cart_screen.dart';
import 'package:food_odering_app/features/checkout/screens/checkout_screen.dart';
import 'package:food_odering_app/features/checkout/screens/order_confirmation_screen.dart';
import 'package:food_odering_app/features/orders/screens/orders_screen.dart';
import 'package:food_odering_app/features/orders/screens/order_details_screen.dart';
import 'package:food_odering_app/features/profile/screens/profile_screen.dart';
import 'package:food_odering_app/features/profile/screens/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main App Routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),

      // Food Details
      GoRoute(
        path: '/food-details/:id',
        name: 'food-details',
        builder: (context, state) {
          final foodId = state.pathParameters['id']!;
          return FoodDetailsScreen(foodId: foodId);
        },
      ),

      // Favorites
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),

      // Cart
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      // Checkout
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),

      // Order Confirmation
      GoRoute(
        path: '/order-confirmation',
        name: 'order-confirmation',
        builder: (context, state) {
          final orderId = state.uri.queryParameters['orderId'];
          return OrderConfirmationScreen(orderId: orderId);
        },
      ),

      // Orders
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
      ),

      // Order Details
      GoRoute(
        path: '/order-details/:id',
        name: 'order-details',
        builder: (context, state) {
          final orderId = state.pathParameters['id']!;
          return OrderDetailsScreen(orderId: orderId);
        },
      ),

      // Profile
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    // Handle redirects (e.g., based on auth state)
    redirect: (BuildContext context, GoRouterState state) {
      // TODO: Add authentication check here later
      // For now, allow all navigation
      return null;
    },

    // Global error handler
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      );
    },
  );
}
