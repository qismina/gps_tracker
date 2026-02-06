import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Dialog shown after completing a walk
class WalkCompletedDialog extends StatelessWidget {
  final Duration duration;
  final double distanceKm;
  final VoidCallback onDone;

  const WalkCompletedDialog({
    super.key,
    required this.duration,
    required this.distanceKm,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: AppTheme.dialogShape,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 48,
                color: AppTheme.successGreen,
              ),
            ),

            const SizedBox(height: AppTheme.spacingL),

            // Title
            const Text(
              'Completed Walk',
              style: AppTheme.screenTitle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppTheme.spacingL),

            // Stats Card
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              decoration: AppTheme.statsCardDecoration,
              child: Column(
                children: [
                  // Duration
                  _buildStatRow(
                    icon: Icons.timer_rounded,
                    label: 'Total Time',
                    value: _formatDuration(duration),
                  ),

                  const SizedBox(height: AppTheme.spacingM),
                  const Divider(),
                  const SizedBox(height: AppTheme.spacingM),

                  // Distance
                  _buildStatRow(
                    icon: Icons.straighten_rounded,
                    label: 'Walking Distance',
                    value: '${distanceKm.toStringAsFixed(2)} km',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacingXL),

            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: AppTheme.primaryButton,
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryPurple, size: 24),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.statLabel),
              const SizedBox(height: 4),
              Text(value, style: AppTheme.sectionHeader),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}