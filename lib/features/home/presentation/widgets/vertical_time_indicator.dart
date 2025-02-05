import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';

class VerticalTimerIndicator extends StatefulWidget {
  final double width;
  final int durationInSeconds;
  final Color color;
  final VoidCallback? onTimerComplete;

  const VerticalTimerIndicator({
    super.key,
    this.width = 8,
    this.durationInSeconds = 30,
    this.color = Colors.green,
    this.onTimerComplete,
  });

  @override
  State<VerticalTimerIndicator> createState() => _VerticalTimerIndicatorState();
}

class _VerticalTimerIndicatorState extends State<VerticalTimerIndicator> {
  late Timer _timer;
  late double _progress;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _progress = 1.0;
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    const updateInterval = 50;
    _timer = Timer.periodic(
      const Duration(milliseconds: updateInterval),
          (timer) {
        setState(() {
          _remainingSeconds =
              widget.durationInSeconds - (timer.tick * updateInterval ~/ 1000);
          _progress = _remainingSeconds / widget.durationInSeconds;

          if (_remainingSeconds <= 0) {
            _timer.cancel();
            widget.onTimerComplete?.call();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: widget.width,
            height: double.infinity, // Takes height from parent SizedBox
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(widget.width / 2),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FractionallySizedBox(
                  heightFactor: _progress,
                  child: Container(
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(widget.width / 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        5.sbH,
        Text(
          '0:$_remainingSeconds',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
