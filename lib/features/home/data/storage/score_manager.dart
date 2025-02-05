import 'package:rock_paper_scissors/features/home/presentation/providers/score_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const String _playerWinsKey = 'player_wins';
  static const String _playerLossesKey = 'player_losses';
  static const String _computerWinsKey = 'computer_wins';
  static const String _computerLossesKey = 'computer_losses';

  static Future<void> saveScore({
    required bool playerWon,
    required SharedPreferences prefs,
  }) async {
    if (playerWon) {
      final playerWins = prefs.getInt(_playerWinsKey) ?? 0;
      final computerLosses = prefs.getInt(_computerLossesKey) ?? 0;
      await prefs.setInt(_playerWinsKey, playerWins + 1);
      await prefs.setInt(_computerLossesKey, computerLosses + 1);
    } else {
      final playerLosses = prefs.getInt(_playerLossesKey) ?? 0;
      final computerWins = prefs.getInt(_computerWinsKey) ?? 0;
      await prefs.setInt(_playerLossesKey, playerLosses + 1);
      await prefs.setInt(_computerWinsKey, computerWins + 1);
    }
  }

  static Future<void> resetScores(SharedPreferences prefs) async {
    await prefs.setInt(_playerWinsKey, 0);
    await prefs.setInt(_computerWinsKey, 0);
    await prefs.setInt(_playerLossesKey, 0);
    await prefs.setInt(_computerLossesKey, 0);
  }

  static ScoreState getScoreData(SharedPreferences prefs) {
    return ScoreState(
        playerWins: prefs.getInt(_playerWinsKey) ?? 0,
        playerLosses: prefs.getInt(_playerLossesKey) ?? 0,
        computerWins: prefs.getInt(_computerWinsKey) ?? 0,
        computerLosses: prefs.getInt(_computerLossesKey) ?? 0);
  }
}
