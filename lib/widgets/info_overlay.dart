import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/tracking_state.dart';

class InfoOverlay extends StatelessWidget {
  final TrackingState state;

  const InfoOverlay({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (!state.isRecording && !state.hasData && !state.isPaused) {
      return const SizedBox.shrink();
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
            vertical: AppTheme.spacingM,
          ),
          decoration: AppTheme.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.isRecording || state.isPaused) ...[
                _buildStatusIndicator(),
                const SizedBox(height: AppTheme.spacingS),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (state.recordingDuration != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer_rounded,
                          color: AppTheme.primaryPurple,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacingS),
                        Text(
                          _formatDuration(state.recordingDuration!),
                          style: AppTheme.sectionHeader.copyWith(
                            color: AppTheme.primaryPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.straighten_rounded,
                        color: AppTheme.primaryPurple,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingS),
                      Text(
                        _formatDistance(state.totalDistance),
                        style: AppTheme.sectionHeader.copyWith(
                          color: AppTheme.primaryPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (state.currentSpeed != null && state.currentSpeed! > 0) ...[
                const SizedBox(height: AppTheme.spacingS),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.speed_rounded,
                      color: AppTheme.primaryPurple,
                      size: 16,
                    ),
                    const SizedBox(width: AppTheme.spacingS),
                    Text(
                      '${_formatSpeed(state.currentSpeed!)} km/h',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!state.isPaused) _PulsingDot(),
        if (!state.isPaused) const SizedBox(width: AppTheme.spacingS),
        Text(
          state.isPaused ? 'Paused' : 'Recording',
          style: AppTheme.bodySmall.copyWith(
            color: state.isPaused ? AppTheme.warningOrange : AppTheme.primaryPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatDistance(double meters) {
    final km = meters / 1000;
    return '${km.toStringAsFixed(2)} km';
  }

  String _formatSpeed(double speedMps) {
    final speedKmh = speedMps * 3.6;
    return speedKmh.toStringAsFixed(1);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final h = hours.toString().padLeft(2, '0');
    final m = minutes.toString().padLeft(2, '0');
    final s = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$h:$m:$s';
    } else {
      return '$m:$s';
    }
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppTheme.primaryPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}