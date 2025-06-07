import 'upgrade.dart';

class GameState {
  double cookieCount;
  double cookiesPerSecond;
  List<Upgrade> upgrades;

  GameState({
    this.cookieCount = 0,
    this.cookiesPerSecond = 0,
    List<Upgrade>? upgrades,
  }) : upgrades = upgrades ?? defaultUpgrades();

  static List<Upgrade> defaultUpgrades() {
    return [
      Upgrade(
        id: 'cursor',
        name: 'Cursor',
        baseCost: 15,
        cpsIncrement: 0.1,
      ),
      Upgrade(
        id: 'grandma',
        name: 'Grandma',
        baseCost: 100,
        cpsIncrement: 1.0,
      ),
      Upgrade(
        id: 'farm',
        name: 'Cookie Farm',
        baseCost: 1100,
        cpsIncrement: 8.0,
      ),
      Upgrade(
        id: 'factory',
        name: 'Cookie Factory',
        baseCost: 12000,
        cpsIncrement: 47.0,
      ),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'cookieCount': cookieCount,
      'cookiesPerSecond': cookiesPerSecond,
      'upgrades': upgrades.map((u) => u.toJson()).toList(),
    };
  }

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      cookieCount: json['cookieCount'],
      cookiesPerSecond: json['cookiesPerSecond'],
      upgrades: (json['upgrades'] as List)
          .map((u) => Upgrade.fromJson(u))
          .toList(),
    );
  }
}
