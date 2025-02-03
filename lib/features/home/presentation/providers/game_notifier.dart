import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rock_paper_scissors/core/extensions/extension.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/game_state.dart';

final gameProvider =
    StateNotifierProvider<GameNotifier, GameState>((ref) => GameNotifier());

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState());

  void makeChoice(Choice choice) {
    ///Generate Computer Choice
    final computerChoice = Choice.values[Random().nextInt(3)];

    ///Determine Game Result
    final gameResult = _determineWinner(choice, computerChoice);

    ///Update State
    state = state.copyWith(
      playerChoice: choice,
      computerChoice: computerChoice,
      gameResult: gameResult,
    );
  }

  ///Determine Game Result
  GameResult _determineWinner(Choice playerChoice, Choice computerChoice) {
    if (playerChoice == computerChoice) return GameResult.draw;

    switch (playerChoice) {
      case Choice.rock:
        return computerChoice == Choice.scissors
            ? GameResult.win
            : GameResult.lose;
      case Choice.paper:
        return computerChoice == Choice.rock ? GameResult.win : GameResult.lose;
      case Choice.scissors:
        return computerChoice == Choice.paper
            ? GameResult.win
            : GameResult.lose;
      default:
        return GameResult.draw;
    }
  }

  void randomChoice(){
    if(state.playerChoice == null){
      final randomChoice = Choice.values[Random().nextInt(3)];
      makeChoice(randomChoice);
    }
  }
}
