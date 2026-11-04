import 'package:flutter/material.dart';

import '../../models/onboarding_page_data.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/onboarding_page_content.dart';
import '../../widgets/onboarding_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() =>
      _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  static const Duration _pageAnimationDuration =
      Duration(milliseconds: 350);

  final PageController _pageController =
      PageController();

  int _currentPage = 0;
  bool _isChangingPage = false;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      title: 'Descubre la región',
      description:
          'Conoce sitios históricos, culturales, naturales y '
          'recreativos de Tampico y Ciudad Madero desde una '
          'guía turística sencilla.',
      icon: Icons.travel_explore_outlined,
      primaryColor: AppColors.maritimeBlue,
      backgroundColor: AppColors.lightMaritimeBlue,
      semanticLabel:
          'Descubre lugares turísticos de Tampico y '
          'Ciudad Madero.',
    ),
    OnboardingPageData(
      title: 'Explora mapas y rutas',
      description:
          'Encuentra lugares cercanos y consulta recorridos '
          'turísticos pensados para aprovechar mejor tu '
          'visita por la región.',
      icon: Icons.route_outlined,
      primaryColor: AppColors.lagoonGreen,
      backgroundColor: AppColors.lightLagoonGreen,
      semanticLabel:
          'Explora mapas, sitios cercanos y rutas turísticas.',
    ),
    OnboardingPageData(
      title: 'Vive experiencias en RA',
      description:
          'Descubre fotografías históricas, objetos digitales '
          'y contenido interactivo mediante futuras '
          'experiencias de realidad aumentada.',
      icon: Icons.view_in_ar_outlined,
      primaryColor: AppColors.darkSandOrange,
      backgroundColor: AppColors.lightSandOrange,
      semanticLabel:
          'Conoce las experiencias de realidad aumentada '
          'de JaibaAR.',
    ),
  ];

  bool get _isFirstPage => _currentPage == 0;

  bool get _isLastPage =>
      _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    if (_isChangingPage) {
      return;
    }

    if (_isLastPage) {
      _finishOnboarding();
      return;
    }

    setState(() {
      _isChangingPage = true;
    });

    await _pageController.nextPage(
      duration: _pageAnimationDuration,
      curve: Curves.easeInOut,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isChangingPage = false;
    });
  }

  Future<void> _goToPreviousPage() async {
    if (_isChangingPage || _isFirstPage) {
      return;
    }

    setState(() {
      _isChangingPage = true;
    });

    await _pageController.previousPage(
      duration: _pageAnimationDuration,
      curve: Curves.easeInOut,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isChangingPage = false;
    });
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
      _isChangingPage = false;
    });
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.visitorSelection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.neutralGray,
        body: SafeArea(
          child: Column(
            children: [
              _OnboardingHeader(
                showBackButton: !_isFirstPage,
                onBackPressed: _goToPreviousPage,
                onSkipPressed: _finishOnboarding,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: _onPageChanged,
                  physics: _isChangingPage
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OnboardingPageContent(
                      page: _pages[index],
                      pageNumber: index + 1,
                      totalPages: _pages.length,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal:
                      AppDimensions.screenHorizontalPadding,
                ),
                child: OnboardingPageIndicator(
                  currentPage: _currentPage,
                  pageCount: _pages.length,
                ),
              ),
              const SizedBox(
                height: AppDimensions.spacingLarge,
              ),
              _OnboardingFooter(
                isLastPage: _isLastPage,
                isLoading: _isChangingPage,
                onContinuePressed: _goToNextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader({
    required this.showBackButton,
    required this.onBackPressed,
    required this.onSkipPressed,
  });

  final bool showBackButton;
  final VoidCallback onBackPressed;
  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.spacingSmall,
        AppDimensions.spacingSmall,
        AppDimensions.spacingSmall,
        0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppDimensions.minimumTouchTarget,
            height: AppDimensions.minimumTouchTarget,
            child: showBackButton
                ? IconButton(
                    tooltip: 'Página anterior',
                    onPressed: onBackPressed,
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Spacer(),
          TextButton(
            onPressed: onSkipPressed,
            child: const Text('Saltar'),
          ),
        ],
      ),
    );
  }
}

class _OnboardingFooter extends StatelessWidget {
  const _OnboardingFooter({
    required this.isLastPage,
    required this.isLoading,
    required this.onContinuePressed,
  });

  final bool isLastPage;
  final bool isLoading;
  final VoidCallback onContinuePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.screenHorizontalPadding,
        0,
        AppDimensions.screenHorizontalPadding,
        AppDimensions.screenVerticalPadding,
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: FilledButton(
          onPressed:
              isLoading ? null : onContinuePressed,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Row(
                    key: ValueKey(
                      'button-content',
                    ),
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLastPage
                            ? 'Comenzar'
                            : 'Siguiente',
                      ),
                      const SizedBox(
                        width:
                            AppDimensions.spacingSmall,
                      ),
                      Icon(
                        isLastPage
                            ? Icons.check_circle_outline
                            : Icons.arrow_forward,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}