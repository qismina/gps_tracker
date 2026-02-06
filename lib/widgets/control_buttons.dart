import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/tracking_state.dart';

class ControlButtons extends StatelessWidget {
  final TrackingState state;
  final GlobalKey mapKey;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;
  final VoidCallback onEndWalk;
  final VoidCallback onAddMarker;

  const ControlButtons({
    super.key,
    required this.state,
    required this.mapKey,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    required this.onEndWalk,
    required this.onAddMarker,
  });

  @override
  Widget build(BuildContext context) {
    if (!state.isRecording && !state.isPaused) {
      return _buildStartButton();
    }

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          Expanded(
            child: _buildControlButton(
              onPressed: state.isPaused ? onResumeRecording : onPauseRecording,
              icon: state.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              label: state.isPaused ? 'Resume' : 'Pause',
              backgroundColor: AppTheme.primaryPurple,
            ),
          ),

          const SizedBox(width: AppTheme.spacingM),

          Expanded(
            child: _buildControlButton(
              onPressed: onEndWalk,
              icon: Icons.stop_rounded,
              label: 'End Walk',
              backgroundColor: AppTheme.errorRed,
            ),
          ),

          const SizedBox(width: AppTheme.spacingM),

          _buildIconButton(
            onPressed: state.canAddMarker ? onAddMarker : null,
            icon: Icons.add_location_rounded,
            enabled: state.canAddMarker,
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      decoration: AppTheme.cardDecoration,
      child: ElevatedButton.icon(
        onPressed: onStartRecording,
        icon: const Icon(Icons.play_arrow_rounded, size: 28),
        label: const Text('Start walking'),
        style: AppTheme.largePrimaryButton.copyWith(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: AppTheme.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required bool enabled,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: enabled
            ? AppTheme.primaryPurple.withValues(alpha:0.1)
            : AppTheme.dividerColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: enabled ? AppTheme.primaryPurple : AppTheme.textGrey,
        ),
      ),
    );
  }
}