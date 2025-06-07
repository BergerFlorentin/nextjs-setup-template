import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../models/upgrade.dart';

class UpgradeList extends StatelessWidget {
  const UpgradeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: viewModel.upgrades.length,
          itemBuilder: (context, index) {
            final upgrade = viewModel.upgrades[index];
            final canAfford = viewModel.cookieCount >= upgrade.currentCost;
            
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  upgrade.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'Cost: ${upgrade.currentCost.toStringAsFixed(0)} cookies\n'
                  'CPS: +${upgrade.cpsIncrement} per unit',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Owned: ${upgrade.quantity}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: canAfford
                          ? () => viewModel.purchaseUpgrade(upgrade.id)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canAfford ? Colors.brown : null,
                        foregroundColor: canAfford ? Colors.white : null,
                      ),
                      child: const Text('Buy'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
