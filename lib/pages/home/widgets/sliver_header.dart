import 'package:flutter/material.dart';
import 'package:waleti/models/models.dart';

import '../../../configs/configs.dart';
import 'package:waleti/shared/ui/ui.dart';

// const _bg = Colors.blue;
const _bg = Color(0xffF8FAF7);

class SliverHeader extends StatelessWidget {
  const SliverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(Constants.appName, style: TextStyle(color: _bg)),
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: _bg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 24),
              const Expanded(
                child: LineChartContainer(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: TabularSwitch<MyTransactionDataType>(
                  onSelect: (selected) {
                    print(selected);
                  },
                  optionNames: const ['Expanse', 'Income'],
                  options: const [MyTransactionDataType.expanse, MyTransactionDataType.income],
                ),
              )
            ],
          ),
          // child: const Center(child: Text('fooo')),
        ),
      ),
    );
  }
}

class SliverListTopRCorner extends StatelessWidget {
  final Widget child;
  const SliverListTopRCorner({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double height = 25;
    return SliverToBoxAdapter(
      child: Container(
        color: _bg,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: mq.size.width,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 2),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height),
                  topRight: Radius.circular(height),
                ),
              ),
              child: child,
            ),
            Positioned(
              bottom: -2,
              right: 0,
              height: 4,
              width: mq.size.width,
              child: Container(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
