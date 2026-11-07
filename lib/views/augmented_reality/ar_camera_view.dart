import 'package:flutter/material.dart';

import '../../models/ar_experience.dart';
import '../../routes/app_routes.dart';
import '../../services/ar_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

/// Simulación didáctica: no abre cámara ni realiza seguimiento espacial.
class ArCameraView extends StatefulWidget {
  const ArCameraView({this.initialPlaceId, super.key});

  final String? initialPlaceId;

  @override
  State<ArCameraView> createState() => _ArCameraViewState();
}

class _ArCameraViewState extends State<ArCameraView> {
  final ArService _service = const MockArService();
  List<ArExperience> _experiences = const [];
  ArExperience? _selected;
  ArSimulationState _state = ArSimulationState.searching;
  bool _audioEnabled = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadExperiences();
  }

  Future<void> _loadExperiences() async {
    final experiences = await _service.getExperiences();
    if (!mounted) return;
    ArExperience? initial;
    for (final experience in experiences) {
      if (experience.placeId == widget.initialPlaceId) {
        initial = experience;
        break;
      }
    }
    setState(() {
      _experiences = experiences;
      _selected = initial ?? (experiences.isEmpty ? null : experiences.first);
      _loading = false;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _setSimulation(ArSimulationState state) {
    setState(() => _state = state);
  }

  void _showInformation() {
    final experience = _selected;
    if (experience == null) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(experience.title),
        content: Text('${experience.description}\n\n${experience.historicalFact}\n\nContenido de demostración, no reconocido por cámara.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_experiences.isEmpty) {
      return const Center(child: Text('No hay experiencias de prueba disponibles.'));
    }
    final experience = _selected!;
    final recognized = _state == ArSimulationState.recognized;
    final status = switch (_state) {
      ArSimulationState.searching => 'Buscando objetivo (simulación)',
      ArSimulationState.recognized => 'Objetivo reconocido (simulado)',
      ArSimulationState.notRecognized => 'No se reconoce el objetivo (simulado)',
      ArSimulationState.outOfRange => 'Fuera del área requerida (simulado)',
    };
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.spacingSmall),
              decoration: BoxDecoration(color: AppColors.lightSandOrange, borderRadius: BorderRadius.circular(AppDimensions.radiusMedium)),
              child: const Text('DEMO RA — Sin cámara ni reconocimiento real', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkMaritimeBlue)),
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.arLive),
              icon: const Icon(Icons.view_in_ar),
              label: const Text('Abrir cámara RA real (ARCore)'),
            ),
            const Text('Requiere un teléfono Android compatible con ARCore y permisos de cámara.', textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.spacingMedium),
            DropdownButtonFormField<String>(
              initialValue: experience.id,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Sitio turístico'),
              items: [for (final item in _experiences) DropdownMenuItem(value: item.id, child: Text(item.placeName, overflow: TextOverflow.ellipsis))],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selected = _experiences.firstWhere((item) => item.id == value);
                  _state = ArSimulationState.searching;
                });
              },
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkMaritimeBlue,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Stack(
                  children: [
                    const Center(child: Icon(Icons.camera_alt_outlined, size: 100, color: AppColors.lightMaritimeBlue)),
                    Align(alignment: const Alignment(0, -0.60), child: Text('VISTA SIMULADA', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white))),
                    if (recognized)
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(AppDimensions.spacingMedium),
                          padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                          decoration: BoxDecoration(color: AppColors.lightMaritimeBlue, borderRadius: BorderRadius.circular(AppDimensions.radiusMedium)),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.view_in_ar, color: AppColors.maritimeBlue, size: 42),
                            Text(experience.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: AppDimensions.spacingSmall),
                            Text(experience.historicalFact, textAlign: TextAlign.center),
                          ]),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                        child: Text(status, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            Text('Apunta al lugar seleccionado. Usa los controles siguientes para probar los estados de la interfaz; no se analiza ninguna imagen.', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppDimensions.spacingMedium),
            Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
              OutlinedButton(onPressed: () => _setSimulation(ArSimulationState.searching), child: const Text('Buscar')),
              FilledButton(onPressed: () => _setSimulation(ArSimulationState.recognized), child: const Text('Reconocer (demo)')),
              OutlinedButton(onPressed: () => _setSimulation(ArSimulationState.notRecognized), child: const Text('Sin objetivo')),
              OutlinedButton(onPressed: () => _setSimulation(ArSimulationState.outOfRange), child: const Text('Fuera de área')),
            ]),
            const SizedBox(height: AppDimensions.spacingSmall),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton.filledTonal(tooltip: 'Información', onPressed: _showInformation, icon: const Icon(Icons.info_outline)),
              IconButton.filledTonal(tooltip: 'Audio simulado', onPressed: () {
                setState(() => _audioEnabled = !_audioEnabled);
                _showMessage(_audioEnabled ? 'Audio activado (demo, sin reproducción)' : 'Audio desactivado (demo)');
              }, icon: Icon(_audioEnabled ? Icons.volume_up : Icons.volume_off)),
              IconButton.filledTonal(tooltip: 'Captura simulada', onPressed: () => _showMessage('Captura simulada: no se guardó ninguna imagen.'), icon: const Icon(Icons.camera)),
              IconButton.filledTonal(tooltip: 'Cerrar simulación', onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  _setSimulation(ArSimulationState.searching);
                  _showMessage('Simulación restablecida. Usa la barra inferior para cambiar de sección.');
                }
              }, icon: const Icon(Icons.close)),
            ]),
          ],
        ),
      ),
    );
  }
}
