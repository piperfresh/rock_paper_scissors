import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rock_paper_scissors/core/extensions/extension.dart';
import 'package:rock_paper_scissors/features/home/data/storage/score_manager.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/game_state.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/score_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gameProvider =
    StateNotifierProvider<GameNotifier, GameState>((ref) => GameNotifier(ref));

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier(this.ref) : super(GameState());

  final Ref ref;

  void saveGameResult() async {
    if (!state.isGameComplete) return;

    final prefs = await SharedPreferences.getInstance();
    final playerWon = state.playerScore > state.computerScore;
    await ScoreManager.saveScore(
      playerWon: playerWon,
      prefs: prefs,
    );
  }

  void makeChoice(Choice playerChoice) async {
    if (state.isGameComplete) return;

    // Generate computer choice
    final random = Random();
    final computerChoice = Choice.values[random.nextInt(3)];

    // Determine winner
    final gameResult = _determineWinner(playerChoice, computerChoice);

    // Update scores
    int playerScore = state.playerScore ?? 0;
    int computerScore = state.computerScore ?? 0;

    if (gameResult == GameResult.win) {
      playerScore++;
    } else if (gameResult == GameResult.lose) {
      computerScore++;
    }

    // Check if game is complete
    bool isGameComplete = state.currentRound == GameState.totalRounds;
    int nextRound =
        isGameComplete ? state.currentRound : state.currentRound + 1;

    /// Update the score
    if (isGameComplete) {
      final playerWon = playerScore > computerScore;
      await ref
          .read(scoreNotifierProvider.notifier)
          .updateScores(playerWon: playerWon);
    }

    state = state.copyWith(
      playerChoice: playerChoice,
      computerChoice: computerChoice,
      gameResult: gameResult,
      playerScore: playerScore,
      computerScore: computerScore,
      currentRound: nextRound,
      isGameComplete: isGameComplete,
    );
  }

  void restartGame() {
    state = GameState();
  }

  GameResult _determineWinner(Choice player, Choice computer) {
    if (player == computer) return GameResult.draw;

    switch (player) {
      case Choice.rock:
        return computer == Choice.scissors ? GameResult.win : GameResult.lose;
      case Choice.paper:
        return computer == Choice.rock ? GameResult.win : GameResult.lose;
      case Choice.scissors:
        return computer == Choice.paper ? GameResult.win : GameResult.lose;
    }
  }
}

// class GameNotifier extends StateNotifier<GameState> {
//   GameNotifier() : super(GameState());
//
//   void makeChoice(Choice choice) {
//     ///Generate Computer Choice
//     final computerChoice = Choice.values[Random().nextInt(3)];
//
//     ///Determine Game Result
//     final gameResult = _determineWinner(choice, computerChoice);
//
//     ///Update State
//     state = state.copyWith(
//       playerChoice: choice,
//       computerChoice: computerChoice,
//       gameResult: gameResult,
//     );
//   }
//
//   ///Determine Game Result
//   GameResult _determineWinner(Choice playerChoice, Choice computerChoice) {
//     if (playerChoice == computerChoice) return GameResult.draw;
//
//     switch (playerChoice) {
//       case Choice.rock:
//         return computerChoice == Choice.scissors
//             ? GameResult.win
//             : GameResult.lose;
//       case Choice.paper:
//         return computerChoice == Choice.rock ? GameResult.win : GameResult.lose;
//       case Choice.scissors:
//         return computerChoice == Choice.paper
//             ? GameResult.win
//             : GameResult.lose;
//       default:
//         return GameResult.draw;
//     }
//   }
//
//   void randomChoice(){
//     if(state.playerChoice == null){
//       final randomChoice = Choice.values[Random().nextInt(3)];
//       makeChoice(randomChoice);
//     }
//   }
// }
