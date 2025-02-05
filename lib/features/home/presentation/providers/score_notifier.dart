import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rock_paper_scissors/features/home/presentation/providers/score_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreNotifier extends StateNotifier<ScoreState> {
  static const String _playerWinKey = 'player_win';
  static const String _playerLossKey = 'player_Loss';
  static const String _computerLossKey = 'computer_Loss';
  static const String _computerWinKey = 'computer_Win';

  ScoreNotifier() : super(ScoreState()) {
    _loadScore();
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    state = ScoreState(
      playerLosses: prefs.getInt(_playerLossKey) ?? 0,
      playerWins: prefs.getInt(_playerWinKey) ?? 0,
      computerLosses: prefs.getInt(_computerLossKey) ?? 0,
      computerWins: prefs.getInt(_computerWinKey) ?? 0,
    );
  }

  Future<void> updateScores({required bool playerWon}) async {
    final prefs = await SharedPreferences.getInstance();
    if (playerWon) {
      final newState = state.copyWith(
        playerWins: state.playerWins + 1,
        computerLosses: state.computerLosses + 1,
      );
      await prefs.setInt(_playerWinKey, newState.playerWins);
      await prefs.setInt(_computerLossKey, newState.computerLosses);
      state = newState;
    } else {
      final newState = state.copyWith(
        computerWins: state.computerWins + 1,
        playerLosses: state.playerLosses + 1,
      );
      await prefs.setInt(_computerWinKey, newState.computerWins);
      await prefs.setInt(_playerLossKey, newState.playerLosses);
      state = newState;
    }
  }

  Future<void> resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_playerLossKey, 0);
    await prefs.setInt(_playerWinKey, 0);
    await prefs.setInt(_computerWinKey, 0);
    await prefs.setInt(_computerLossKey, 0);
  }
}

final scoreNotifierProvider =
    StateNotifierProvider<ScoreNotifier, ScoreState>((ref) => ScoreNotifier());
