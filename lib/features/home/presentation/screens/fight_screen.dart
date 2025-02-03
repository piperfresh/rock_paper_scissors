import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissors/core/extensions/asset.dart';
import 'package:rock_paper_scissors/core/extensions/build_context.dart';
import 'package:rock_paper_scissors/core/extensions/extension.dart';
import 'package:rock_paper_scissors/core/extensions/size_extension.dart';
import 'package:rock_paper_scissors/core/utils/app_color.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/game_notifier.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/game_state.dart';

class FightScreen extends ConsumerStatefulWidget {
  const FightScreen({super.key});

  @override
  ConsumerState<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends ConsumerState<FightScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _handAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _handAnimation = Tween<double>(begin: -0.1, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticOut));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticOut));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeOutBack));
    super.initState();
  }

  String getHandAsset(bool isPlayer, Choice? choice) {
    if (choice == null) {
      return isPlayer ? 'hand_1'.svg : 'hand_2'.svg;
    }

    switch (choice) {
      case Choice.rock:
        return isPlayer ? 'rock_hand'.svg : 'ai_rock'.svg;
      case Choice.paper:
        return isPlayer ? 'paper_hand'.svg : 'ai_paper'.svg;
      case Choice.scissors:
        return isPlayer ? 'scissors_hand_2'.svg : 'ai_scissors'.svg;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedHand({
    required bool isPlayer,
    required Choice? choice,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _scaleAnimation.value : 1.0,
            child: Transform.rotate(
              angle: isSelected ? _handAnimation.value : 1.0,
              child: SvgPicture.asset(getHandAsset(isPlayer, choice),height: 400.h,),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultText(GameState gameState) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: Text(
              gameState.gameResult == null
                  ? 'FIGHT'
                  : gameState.gameResult!.name.toUpperCase(),
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 56.sp,
                fontWeight: FontWeight.w400,
                color: _getResultColor(gameState.gameResult),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getResultColor(GameResult? result) {
    switch (result) {
      case GameResult.win:
        return Colors.green;
      case GameResult.lose:
        return Colors.red;
      case GameResult.draw:
        return Colors.amber;
      default:
        return Colors.white;
    }
  }

  Widget _buildChoiceButton({
    required String assetPath,
    required Choice choice,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(gameProvider.notifier).makeChoice(choice);
        _animationController.forward(from: 0.0);
      },
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _scaleAnimation.value : 1.0,
              child: SvgPicture.asset(assetPath),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final randomChoice = Choice.values[Random().nextInt(3)];

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0.h,
            right: 0.w,
            left: 0.w,
            top: 0.h,
            child: SvgPicture.asset(
              'fill'.svg,
            ),
          ),
          Positioned(
            left: 16.w,
            top: 300.h,
            child: SizedBox(
              height: 200.h, // Control the height here
              child: VerticalTimerIndicator(
                onTimerComplete: () {
                  // if (isGameActive) {
                  //   // _randomChoice();
                  // }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            right: 0.w,
            left: 0.w,
            top: 0.h,
            child: Center(
              child: Text(
                gameState.gameResult == null
                    ? 'FIGHT'
                    : gameState.gameResult!.name.toUpperCase(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 56.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 50.h,
            child: Center(
              child: Text(
                'Round 1',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Positioned(
          //     top: 0,
          //     child: SvgPicture.asset(
          //       getHandAsset(false, gameState.computerChoice),
          //       height: 400.h,
          //     )),
          // Positioned(
          //   bottom: 0,
          //   child: SvgPicture.asset(
          //     getHandAsset(true, gameState.playerChoice),
          //     height: 400.h,
          //   ),
          // ),
          Positioned(
            top: 0,
            child: _buildAnimatedHand(
              isPlayer: false,
              choice: gameState.computerChoice,
              onTap: () {},
              isSelected: gameState.computerChoice != null,
            ),
          ),

          // Player's Hand
          Positioned(
            bottom: 0,
            child: _buildAnimatedHand(
              isPlayer: true,
              choice: gameState.playerChoice,
              onTap: () {},
              isSelected: gameState.playerChoice != null,
            ),
          ),
          Positioned(
            bottom: 38.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () {
                ref.read(gameProvider.notifier).makeChoice(Choice.rock);
              },
              child: AnimatedOpacity(
                opacity: gameState.playerChoice == Choice.rock ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset('stone'.svg),
              ),
            ),
          ),
          Positioned(
            bottom: 38.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                ref.read(gameProvider.notifier).makeChoice(Choice.scissors);
              },
              child: AnimatedOpacity(
                opacity: gameState.playerChoice == Choice.scissors ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset('scissors'.svg),
              ),
            ),
          ),
          Positioned(
            bottom: 120.h,
            right: 0.w,
            left: 0.w,
            child: GestureDetector(
              onTap: () {
                ref.read(gameProvider.notifier).makeChoice(Choice.paper);
              },
              child: AnimatedOpacity(
                opacity: gameState.playerChoice == Choice.paper ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset('paper'.svg),
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            right: 0.w,
            left: 0.w,
            child: GestureDetector(
              onTap: () {
                // final randomChoice = Choice.values[Random().nextInt(3)];
                ref.read(gameProvider.notifier).makeChoice(randomChoice);
              },
              child: AnimatedOpacity(
                  opacity:  0.5,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset('random_selector'.svg)),
            ),
          ),
        ],
      ),
    );
  }
}

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
