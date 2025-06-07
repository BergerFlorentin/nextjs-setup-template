import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/game_state.dart';
import '../models/upgrade.dart';

class GameViewModel extends ChangeNotifier {
  GameState _gameState = GameState();
  Timer? _autoClickTimer;

  GameViewModel() {
    _startAutoClicker();
  }

  double get cookieCount => _gameState.cookieCount;
  double get cookiesPerSecond => _gameState.cookiesPerSecond;
  List<Upgrade> get upgrades => _gameState.upgrades;

  void clickCookie() {
    _gameState.cookieCount += 1;
    notifyListeners();
  }

  void purchaseUpgrade(String upgradeId) {
    final upgrade = _gameState.upgrades.firstWhere((u) => u.id == upgradeId);
    if (_gameState.cookieCount >= upgrade.currentCost) {
      _gameState.cookieCount -= upgrade.currentCost;
      upgrade.quantity++;
      _updateCookiesPerSecond();
      notifyListeners();
    }
  }

  void _updateCookiesPerSecond() {
    _gameState.cookiesPerSecond = _gameState.upgrades.fold(
      0,
      (sum, upgrade) => sum + (upgrade.cpsIncrement * upgrade.quantity),
    );
  }

  void _startAutoClicker() {
    _autoClickTimer?.cancel();
    _autoClickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _gameState.cookieCount += _gameState.cookiesPerSecond;
      notifyListeners();
    });
  }

  void resetGame() {
    _gameState = GameState();
    notifyListeners();
  }

  @override
  void dispose() {
    _autoClickTimer?.cancel();
    super.dispose();
  }
}
