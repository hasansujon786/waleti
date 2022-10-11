import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:waleti/controllers/controllers.dart';
import 'package:waleti/models/goal.dart';
import 'package:waleti/screens/goals/view/widgets/slidable_cards.dart';

class GoalsView extends ConsumerWidget {
  const GoalsView({super.key});

  static const routeName = '/goals_view';

  @override
  Widget build(BuildContext context, ref) {
    final goalsController = ref.read(goalListControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              goalsController.addItem(item: Goal(title: 'moo', targetAmout: 300));
              // goalsController.deleteAllGoals();
              print('goalsController.addItem');
            },
          )
        ],
      ),
      body: Stack(
        children: [
          ref.watch(goalListControllerProvider).when(
                data: (goals) => SlidableCards(items: goals),
                error: (e, _) => const Text('error'),
                loading: () => const Text('Loading...'),
              ),
          TextButton(
            onPressed: () {
              goalsController.deleteAllGoals();
            },
            child: const Text('delet all'),
          )
        ],
      ),
    );
  }
}
