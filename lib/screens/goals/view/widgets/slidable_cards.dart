import 'dart:math';
import 'package:flutter/material.dart';
import 'package:waleti/models/models.dart';

import 'goal_card.dart';

class SlidableCards extends StatefulWidget {
  const SlidableCards({Key? key, required this.items}) : super(key: key);
  final List<Goal> items;

  @override
  State<SlidableCards> createState() => _SlidableCardsState();
}

class _SlidableCardsState extends State<SlidableCards> {
  var _items = <Goal>[];
  var _page = 0.0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    _items = widget.items;

    pageController = PageController(initialPage: _items.length);
    pageController.addListener(() {
      setState(() {
        _page = pageController.page ?? 0;
      });
    });
  }

  @override
  void didUpdateWidget(covariant SlidableCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = widget.items;
      pageController.animateToPage(
        widget.items.length,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    pageController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width,
          child: LayoutBuilder(
            builder: (context, boxConstraints) {
              const topCardVerPadding = 20.0;
              const otherCardsVerPadding = 30.0;
              const slideRatio = 0.90;
              List<Widget> cards = [];

              for (int i = 0; i < _items.length; i++) {
                final currentPageValue = i - _page;
                final pageLocationDistance = currentPageValue > 0 ? 30 : 1;
                final leftPad = boxConstraints.maxWidth - width * slideRatio;
                double start = 30 + max(leftPad - (leftPad / 2) * -currentPageValue * pageLocationDistance, 0.0);

                var customizableCard = Positioned.directional(
                  start: topCardVerPadding + otherCardsVerPadding * max(-currentPageValue, 0.0),
                  end: topCardVerPadding + otherCardsVerPadding * max(-currentPageValue, 0.0),
                  height: boxConstraints.maxWidth * 1.1,
                  top: start,
                  textDirection: TextDirection.ltr,
                  child: buildCard(width, i),
                );
                cards.add(customizableCard);
              }
              return Stack(children: cards);
            },
          ),
        ),
        Positioned.fill(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: _items.length,
            controller: pageController,
            itemBuilder: (context, index) => const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget buildCard(double width, int pageIndex) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10)],
      ),
      // child: GoalCard(widget.items[pageIndex]),
      child: Text(pageIndex.toString()),
    );
  }
}
