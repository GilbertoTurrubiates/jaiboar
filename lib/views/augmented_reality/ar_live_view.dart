import 'package:ar_flutter_plugin_plus/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_plus/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_plus/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_plus/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_plus/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_plus/managers/ar_session_manager.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Prueba real de ARCore: cámara, seguimiento y detección de superficies.
/// No identifica aún edificios ni coloca reconstrucciones históricas.
class ArLiveView extends StatefulWidget {
  const ArLiveView({super.key});

  @override
  State<ArLiveView> createState() => _ArLiveViewState();
}

class _ArLiveViewState extends State<ArLiveView> {
  ARSessionManager? _session;
  String _status = 'Iniciando cámara y seguimiento espacial…';
  bool _ready = false;
  int _surfaceTouches = 0;

  Future<void> _onCreated(
    ARSessionManager session,
    ARObjectManager objects,
    ARAnchorManager anchors,
    ARLocationManager locations,
  ) async {
    _session = session;
    try {
      await session.onInitialize(
        showPlanes: true,
        showFeaturePoints: true,
        showAnimatedGuide: true,
        handleTaps: true,
      );
      session.onPlaneOrPointTap = (hits) {
        if (!mounted || hits.isEmpty) return;
        setState(() {
          _surfaceTouches++;
          _status = 'Superficie o punto detectado mediante ARCore. '
              'Toques: $_surfaceTouches';
        });
      };
      if (!mounted) return;
      setState(() {
        _ready = true;
        _status = 'Mueve el teléfono lentamente y toca una superficie '
            'marcada para comprobar el seguimiento real.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = 'No fue posible iniciar ARCore: $e';
      });
    }
  }

  @override
  void dispose() {
    _session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cámara RA real · Prueba técnica')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ARView(
                    onARViewCreated: _onCreated,
                    planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
                    permissionPromptDescription:
                        'JaibaAR necesita utilizar la cámara para mostrar realidad aumentada.',
                    permissionPromptButtonText: 'Permitir cámara',
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.darkMaritimeBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _ready ? 'ARCore activo · Detección de planos' : 'Preparando ARCore',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.neutralGray,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(_status, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  const Text(
                    'Fase 17: seguimiento espacial auténtico. '
                    'No hay reconocimiento de edificios, modelos 3D ni fotos históricas todavía.',
                    style: TextStyle(color: AppColors.secondaryText),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
