import 'package:flutter/material.dart';

import '../../models/visitor_type.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/visitor_type_card.dart';

class VisitorSelectionView extends StatefulWidget {
  const VisitorSelectionView({super.key});

  @override
  State<VisitorSelectionView> createState() =>
      _VisitorSelectionViewState();
}

class _VisitorSelectionViewState
    extends State<VisitorSelectionView> {
  VisitorType? _selectedVisitorType;

  bool get _hasSelection => _selectedVisitorType != null;

  void _selectVisitorType(VisitorType type) {
    setState(() {
      _selectedVisitorType = type;
    });
  }

  void _continueWithSelectedProfile() {
    final VisitorType? selectedType = _selectedVisitorType;

    if (selectedType == null) {
      _showSelectionMessage();
      return;
    }

    _openHome(
      visitorType: selectedType,
    );
  }

  void _continueAsGuest() {
    _openHome();
  }

  void _openHome({
    VisitorType? visitorType,
  }) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
      arguments: visitorType,
    );
  }

  void _showSelectionMessage() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Selecciona un perfil o continúa como invitado.',
          ),
        ),
      );
  }

  Future<bool> _confirmExit() async {
    final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('¿Salir de JaibaAR?'),
          content: const Text(
            'Todavía no has terminado la configuración inicial.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Salir'),
            ),
          ],
        );
      },
    );

    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }

        final bool shouldExit = await _confirmExit();

        if (!mounted || !shouldExit) {
          return;
        }

        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.neutralGray,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Configura tu experiencia'),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool useHorizontalLayout =
                  constraints.maxWidth >= 760;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal:
                      AppDimensions.screenHorizontalPadding,
                  vertical:
                      AppDimensions.screenVerticalPadding,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 900,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        const _VisitorSelectionHeader(),
                        const SizedBox(
                          height: AppDimensions.spacingLarge,
                        ),
                        if (useHorizontalLayout)
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: VisitorTypeCard(
                                  title: 'Soy turista',
                                  description:
                                      'Visito la región y quiero conocer '
                                      'lugares destacados, rutas y datos '
                                      'prácticos para aprovechar mi viaje.',
                                  icon:
                                      Icons.luggage_outlined,
                                  isSelected:
                                      _selectedVisitorType ==
                                          VisitorType.tourist,
                                  onPressed: () {
                                    _selectVisitorType(
                                      VisitorType.tourist,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width:
                                    AppDimensions.spacingMedium,
                              ),
                              Expanded(
                                child: VisitorTypeCard(
                                  title: 'Soy habitante local',
                                  description:
                                      'Vivo en la región y quiero descubrir '
                                      'nuevas actividades, historia local y '
                                      'lugares para visitar.',
                                  icon:
                                      Icons.home_work_outlined,
                                  isSelected:
                                      _selectedVisitorType ==
                                          VisitorType
                                              .localResident,
                                  onPressed: () {
                                    _selectVisitorType(
                                      VisitorType
                                          .localResident,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else ...[
                          VisitorTypeCard(
                            title: 'Soy turista',
                            description:
                                'Visito la región y quiero conocer lugares '
                                'destacados, rutas y datos prácticos para '
                                'aprovechar mi viaje.',
                            icon: Icons.luggage_outlined,
                            isSelected:
                                _selectedVisitorType ==
                                    VisitorType.tourist,
                            onPressed: () {
                              _selectVisitorType(
                                VisitorType.tourist,
                              );
                            },
                          ),
                          const SizedBox(
                            height: AppDimensions.spacingMedium,
                          ),
                          VisitorTypeCard(
                            title: 'Soy habitante local',
                            description:
                                'Vivo en la región y quiero descubrir '
                                'nuevas actividades, historia local y '
                                'lugares para visitar.',
                            icon: Icons.home_work_outlined,
                            isSelected:
                                _selectedVisitorType ==
                                    VisitorType.localResident,
                            onPressed: () {
                              _selectVisitorType(
                                VisitorType.localResident,
                              );
                            },
                          ),
                        ],
                        const SizedBox(
                          height: AppDimensions.spacingLarge,
                        ),
                        _SelectionSummary(
                          visitorType:
                              _selectedVisitorType,
                        ),
                        const SizedBox(
                          height:
                              AppDimensions.spacingExtraLarge,
                        ),
                        FilledButton.icon(
                          onPressed: _hasSelection
                              ? _continueWithSelectedProfile
                              : null,
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                          label: const Text(
                            'Continuar con este perfil',
                          ),
                        ),
                        const SizedBox(
                          height: AppDimensions.spacingSmall,
                        ),
                        TextButton(
                          onPressed: _continueAsGuest,
                          child: const Text(
                            'Continuar como invitado',
                          ),
                        ),
                        const SizedBox(
                          height: AppDimensions.spacingSmall,
                        ),
                        Text(
                          'Podrás modificar esta preferencia más adelante '
                          'desde la configuración.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color:
                                    AppColors.secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VisitorSelectionHeader extends StatelessWidget {
  const _VisitorSelectionHeader();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: const BoxDecoration(
              color: AppColors.lightMaritimeBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_pin_circle_outlined,
              color: AppColors.maritimeBlue,
              size: 42,
            ),
          ),
          const SizedBox(
            height: AppDimensions.spacingMedium,
          ),
          Text(
            '¿Cómo deseas explorar JaibaAR?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: AppDimensions.spacingSmall,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 620,
            ),
            child: Text(
              'Selecciona el perfil que más se parezca a ti. '
              'Esta elección ayudará a personalizar futuras '
              'recomendaciones.',
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.secondaryText,
                        height: 1.5,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionSummary extends StatelessWidget {
  const _SelectionSummary({
    required this.visitorType,
  });

  final VisitorType? visitorType;

  @override
  Widget build(BuildContext context) {
    final String message;
    final IconData icon;
    final Color iconColor;

    switch (visitorType) {
      case VisitorType.tourist:
        message = 'Perfil seleccionado: Turista';
        icon = Icons.luggage_outlined;
        iconColor = AppColors.maritimeBlue;

      case VisitorType.localResident:
        message = 'Perfil seleccionado: Habitante local';
        icon = Icons.home_work_outlined;
        iconColor = AppColors.lagoonGreen;

      case null:
        message = 'Todavía no has seleccionado un perfil';
        icon = Icons.info_outline;
        iconColor = AppColors.secondaryText;
    }

    return Semantics(
      liveRegion: true,
      label: message,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(
          AppDimensions.spacingMedium,
        ),
        decoration: BoxDecoration(
          color: visitorType == null
              ? AppColors.white
              : AppColors.lightLagoonGreen,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: visitorType == null
                ? AppColors.border
                : AppColors.lagoonGreen,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: AppDimensions.iconMedium,
            ),
            const SizedBox(
              width: AppDimensions.spacingMedium,
            ),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}