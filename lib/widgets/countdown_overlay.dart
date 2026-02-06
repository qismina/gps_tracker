import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Countdown overlay (3, 2, 1) before starting walk
class CountdownOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const CountdownOverlay({
    super.key,
    required this.onComplete,
  });

  @override
  State<CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  int _currentCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _startCountdown();
  }

  void _startCountdown() async {
    for (int i = 3; i > 0; i--) {
      setState(() => _currentCount = i);
      _controller.forward(from: 0);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    widget.onComplete();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha:0.7),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Text(
                  '$_currentCount',
                  style: AppTheme.countdownText,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}