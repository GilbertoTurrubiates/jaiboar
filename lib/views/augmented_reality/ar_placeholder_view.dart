import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/placeholder_section_view.dart';

class ArPlaceholderView extends StatelessWidget {
  const ArPlaceholderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderSectionView(
      title: 'Cámara RA',
      description:
          'Explora experiencias interactivas de realidad aumentada '
          'relacionadas con la historia y la cultura regional.',
      icon: Icons.view_in_ar_outlined,
      iconColor: AppColors.darkSandOrange,
      iconBackgroundColor: AppColors.lightSandOrange,
      pendingMessage:
          'La cámara y la realidad aumentada todavía no están activas. '
          'Primero se desarrollará una interfaz simulada y posteriormente '
          'se seleccionará la tecnología RA.',
    );
  }
}