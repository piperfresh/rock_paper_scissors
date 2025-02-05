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

import '../widgets/game_overlay.dart';
import '../widgets/score_board.dart';

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
        return isPlayer ? 'scissors_hand'.svg : 'ai_scissors'.svg;
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
            // scale: isSelected ? _scaleAnimation.value : 1.0,
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              // angle: isSelected ? _handAnimation.value : 1.0,
              angle: _handAnimation.value,
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
          // Positioned(
          //   left: 16.w,
          //   top: 300.h,
          //   child: SizedBox(
          //     height: 200.h, // Control the height here
          //     child: VerticalTimerIndicator(
          //       onTimerComplete: () {
          //         // if (isGameActive) {
          //         //   // _randomChoice();
          //         // }
          //       },
          //     ),
          //   ),
          // ),
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
            child: ScoreBoard(
              playerScore: gameState.playerScore,
              computerScore: gameState.computerScore,
              currentRound: gameState.currentRound,
            ),
          ),

          // Positioned(
          //   right: 20.w,
          //   top: 50.h,
          //   child: Center(
          //     child: Text(
          //       'Round 1',
          //       style: context.textTheme.bodySmall?.copyWith(
          //         fontSize: 24.sp,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          // ),
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
                ref.read(gameProvider.notifier).makeChoice(randomChoice);
              },
              child: AnimatedOpacity(
                  opacity:  0.5,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset('random_selector'.svg)),
            ),
          ),
          if (gameState.isGameComplete)
            GameOverOverlay(
              playerScore: gameState.playerScore ,
              computerScore: gameState.computerScore ,
              onRestart: () {
                ref.read(gameProvider.notifier).restartGame();
                _animationController.reset();
              },
            ),
        ],
      ),
    );
  }
}

