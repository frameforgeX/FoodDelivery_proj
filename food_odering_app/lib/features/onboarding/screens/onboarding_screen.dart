import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_odering_app/core/constants/app_colors.dart';

/// Onboarding screen inspired by the provided food delivery mockup
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              width: 390,
              // padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F6F3),
                borderRadius: BorderRadius.circular(42),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withValues(alpha: 0.08),
                //     blurRadius: 26,
                //     spreadRadius: 1,
                //     offset: const Offset(0, 10),
                //   ),
                // ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Text(
                      //   '9:41',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w700,
                      //     color: AppColors.textPrimary,
                      //   ),
                      // ),
                      // Row(
                      //   children: const [
                      //     Icon(Icons.signal_cellular_4_bar_rounded, size: 18),
                      //     SizedBox(width: 6),
                      //     Icon(Icons.wifi_rounded, size: 18),
                      //     SizedBox(width: 6),
                      //     Icon(Icons.battery_5_bar_rounded, size: 18),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 180,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFE7E2DE),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 110,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delicious\nfood, delivered\nfast to you',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        height: 0.98,
                        letterSpacing: -1.8,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Order your favorite meals from local\nrestaurants and enjoy fast delivery\nat your doorstep.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color(0xFFF2E1D6),
                    ),
                    child: const Text(
                      'Available for PRO members',
                      style: TextStyle(
                        color: AppColors.secondaryDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 18,
                          bottom: 16,
                          child: Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.delivery_dining_rounded,
                              color: AppColors.secondary,
                              size: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              color: AppColors.secondary,
                              size: 28,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 18,
                          right: 32,
                          child: CustomPaint(
                            size: const Size(120, 80),
                            painter: DashedArcPainter(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFECC88E),
                                Color(0xFFCB8C42),
                              ],
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=80',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.fastfood_rounded,
                                size: 90,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () => context.go('/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.arrow_forward_rounded, size: 28),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB9AFA9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 8;
    const dashSpace = 6;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final arc = Path()
      ..addArc(
        Rect.fromCenter(
          center: rect.center,
          width: size.width,
          height: size.height,
        ),
        1.0,
        2.7,
      );

    final metrics = arc.computeMetrics().toList();
    for (final metric in metrics) {
      final total = metric.length;
      double start = 0;
      while (start < total) {
        final end = start + dashWidth;
        final segment = metric.extractPath(start, end);
        canvas.drawPath(segment, paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
