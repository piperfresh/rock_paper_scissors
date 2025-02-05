class ScoreState {
  final int playerWins;
  final int playerLosses;
  final int computerWins;
  final int computerLosses;

  ScoreState({
    this.playerWins = 0,
    this.playerLosses = 0,
    this.computerWins = 0,
    this.computerLosses = 0,
  });

  ScoreState copyWith({
    int? playerWins,
    int? playerLosses,
    int? computerWins,
    int? computerLosses,
  }) {
    return ScoreState(
      playerWins: playerWins ?? this.playerWins,
      playerLosses: playerLosses ?? this.playerLosses,
      computerWins: computerWins ?? this.computerWins,
      computerLosses: computerLosses ?? this.computerLosses,
    );
  }
}
