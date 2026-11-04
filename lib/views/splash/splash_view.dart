import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  static const Duration _splashDuration = Duration(seconds: 3);
  static const Duration _animationDuration =
      Duration(milliseconds: 900);

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _navigationTimer;
  bool _navigationScheduled = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.88,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_navigationScheduled) {
      return;
    }

    _navigationScheduled = true;

    final bool reduceAnimations =
        MediaQuery.of(context).disableAnimations;

    if (reduceAnimations) {
      _animationController.value = 1;
    }

    final Duration navigationDelay = reduceAnimations
        ? const Duration(milliseconds: 800)
        : _splashDuration;

    _navigationTimer = Timer(
      navigationDelay,
      _navigateToOnboarding,
    );
  }

  void _navigateToOnboarding() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.onboarding,
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final bool compactScreen = screenSize.height < 600;

    return Scaffold(
      backgroundColor: AppColors.maritimeBlue,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(
              child: _SplashBackground(),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.screenHorizontalPadding,
                  vertical: AppDimensions.screenVerticalPadding,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 520,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: _SplashContent(
                        compactScreen: compactScreen,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: AppDimensions.screenHorizontalPadding,
              right: AppDimensions.screenHorizontalPadding,
              bottom: AppDimensions.spacingLarge,
              child: _SplashFooter(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: AppColors.darkLagoonGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColors.lagoonGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -50,
            child: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                color: AppColors.darkSandOrange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({
    required this.compactScreen,
  });

  final bool compactScreen;

  @override
  Widget build(BuildContext context) {
    final double logoSize = compactScreen ? 110 : 140;

    return Semantics(
      label: 'JaibaAR, guía turística interactiva',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ProvisionalLogo(
            size: logoSize,
          ),
          SizedBox(
            height: compactScreen
                ? AppDimensions.spacingMedium
                : AppDimensions.spacingLarge,
          ),
          Text(
            'JaibaAR',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(
            height: AppDimensions.spacingSmall,
          ),
          Text(
            'Descubre Tampico y Ciudad Madero',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: AppDimensions.spacingMedium,
          ),
          Text(
            'Historia, cultura, naturaleza y tecnología '
            'en una sola experiencia.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightMaritimeBlue,
                  height: 1.5,
                ),
          ),
          SizedBox(
            height: compactScreen
                ? AppDimensions.spacingLarge
                : AppDimensions.spacingExtraLarge,
          ),
          const _LoadingIndicator(),
        ],
      ),
    );
  }
}

class _ProvisionalLogo extends StatelessWidget {
  const _ProvisionalLogo({
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Logotipo provisional de JaibaAR',
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.lightSandOrange,
            width: 4,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.darkMaritimeBlue,
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.travel_explore,
              size: size * 0.5,
              color: AppColors.maritimeBlue,
            ),
            Positioned(
              right: size * 0.14,
              bottom: size * 0.14,
              child: Container(
                width: size * 0.31,
                height: size * 0.31,
                decoration: const BoxDecoration(
                  color: AppColors.sandOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.view_in_ar_outlined,
                  size: size * 0.19,
                  color: AppColors.darkMaritimeBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cargando aplicación',
      child: const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.sandOrange,
          backgroundColor: AppColors.lightMaritimeBlue,
        ),
      ),
    );
  }
}

class _SplashFooter extends StatelessWidget {
  const _SplashFooter();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Guía turística interactiva',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.lightMaritimeBlue,
            letterSpacing: 0.6,
          ),
    );
  }
}