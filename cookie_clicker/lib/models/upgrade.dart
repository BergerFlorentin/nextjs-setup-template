class Upgrade {
  final String id;
  final String name;
  final double baseCost;
  int quantity;
  final double cpsIncrement;
  final double costMultiplier;

  Upgrade({
    required this.id,
    required this.name,
    required this.baseCost,
    this.quantity = 0,
    required this.cpsIncrement,
    this.costMultiplier = 1.15,
  });

  double get currentCost => baseCost * (costMultiplier * quantity);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'baseCost': baseCost,
      'quantity': quantity,
      'cpsIncrement': cpsIncrement,
      'costMultiplier': costMultiplier,
    };
  }

  factory Upgrade.fromJson(Map<String, dynamic> json) {
    return Upgrade(
      id: json['id'],
      name: json['name'],
      baseCost: json['baseCost'],
      quantity: json['quantity'],
      cpsIncrement: json['cpsIncrement'],
      costMultiplier: json['costMultiplier'],
    );
  }
}
