import 'package:flutter/material.dart';

import 'ar_camera_view.dart';

/// Se mantiene el nombre original para no romper la navegación existente.
class ArPlaceholderView extends StatelessWidget {
  const ArPlaceholderView({super.key});

  @override
  Widget build(BuildContext context) => const ArCameraView();
}
