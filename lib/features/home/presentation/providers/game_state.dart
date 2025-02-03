import 'package:rock_paper_scissors/core/extensions/extension.dart';

class GameState {
  Choice? playerChoice;
  Choice? computerChoice;
  GameResult? gameResult;

  GameState({
    this.playerChoice,
    this.computerChoice,
    this.gameResult,
  });

  GameState copyWith({
    Choice? playerChoice,
    Choice? computerChoice,
    GameResult? gameResult,
  }) {
    return GameState(
      playerChoice: playerChoice ?? this.playerChoice,
      computerChoice: computerChoice ?? this.computerChoice,
      gameResult: gameResult ?? this.gameResult,
    );
  }
}
