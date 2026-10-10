import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color? primaryColor;

  const AnimatedCounter({
    Key? key,
    this.initialValue = 0,
    this.maxValue = 100,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor,
  }) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    final baseColor = widget.primaryColor ?? Colors.blue;
    _colorAnimation = ColorTween(
      begin: baseColor,
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    if (_currentValue < widget.maxValue) {
      setState(() {
        _currentValue++;
      });
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  void _decrement() {
    if (_currentValue > 0) {
      setState(() {
        _currentValue--;
      });
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                '$_currentValue',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _currentValue >= widget.maxValue
                      ? Colors.red
                      : (_colorAnimation.value ?? Colors.blue),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: LinearProgressIndicator(
            value: _currentValue / widget.maxValue,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              _currentValue >= widget.maxValue ? Colors.red : Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _decrement,
              child: const Text('-', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('+', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ],
    );
  }
}
