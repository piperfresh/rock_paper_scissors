import 'package:rock_paper_scissors/core/extensions/extension.dart';

class GameState {
  Choice? playerChoice;
  Choice? computerChoice;
  GameResult? gameResult;
  int currentRound;
  int playerScore;
  int computerScore;
  bool isGameComplete;
  static const int totalRounds = 3;

  GameState({
    this.playerChoice,
    this.computerChoice,
    this.gameResult,
    this.computerScore = 0,
    this.currentRound = 1,
    this.playerScore = 0,
    this.isGameComplete = false,
  });

  GameState copyWith({
    Choice? playerChoice,
    Choice? computerChoice,
    GameResult? gameResult,
    int? currentRound,
    int? playerScore,
    int? computerScore,
    bool? isGameComplete,
  }) {
    return GameState(
      playerChoice: playerChoice ?? this.playerChoice,
      computerChoice: computerChoice ?? this.computerChoice,
      gameResult: gameResult ?? this.gameResult,
      computerScore: computerScore ?? this.computerScore,
      playerScore: playerScore ?? this.playerScore,
      currentRound: currentRound ?? this.currentRound,
      isGameComplete: isGameComplete ?? this.isGameComplete,
    );
  }
}
