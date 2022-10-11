import 'package:flutter/material.dart';
import 'package:waleti/shared/ui/ui.dart';

class AccountCardHeader extends StatelessWidget {
  const AccountCardHeader({super.key, required this.bg});

  final Color bg;

  @override
  Widget build(BuildContext context) {
    // final transactionsRef = ref.watch(filteredTransactionsByWeek);
    // final transactionListFilter = ref.watch(transactionListFilterProvider.state);
    // final totalExpence = ref.watch(totalExpenceOfSelectedWeek);
    // final totalIncome = ref.watch(totalIncomeOfSelectedWeek);
    // final currentWeekDates = ref.watch(weekViewControllerProvider);

    return FlexibleSpaceBar(
      background: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: bg)),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ClipPath(
              clipper: MyArcClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade600, Colors.teal],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greet(context),
                const SizedBox(height: 20),
                const _Card(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget greet(context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good afternoon,',
              style: tt.labelMedium?.copyWith(color: Colors.grey.shade300),
            ),
            const SizedBox(height: 2),
            Text(
              'Hasan Mahmud',
              style: tt.titleLarge?.copyWith(color: Colors.grey.shade300),
            ),
          ],
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {},
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.teal),
            child: const Icon(Icons.notifications, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance', style: tt.titleSmall?.copyWith(color: Colors.grey.shade200)),
            const SizedBox(height: 6),
            Text(
              '\$1234234.23',
              style: tt.headlineSmall?.copyWith(
                color: Colors.grey.shade100,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userAmount(context, false, 23434.2),
                userAmount(context, true, 23434.2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userAmount(BuildContext context, bool isExpanse, double amout) {
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: isExpanse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(children: [
          IconBox(
            icon: Icon(
              isExpanse ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 6),
          Text(isExpanse ? 'Expence' : 'Income', style: tt.titleSmall?.copyWith(color: Colors.grey.shade200)),
        ]),
        const SizedBox(height: 10),
        Text('\$$amout', style: tt.titleLarge?.copyWith(color: Colors.grey.shade100)),
      ],
    );
  }
}

class MyArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    // Arc
    final path = Path()
      ..lineTo(0, h - 50)
      ..quadraticBezierTo(w * .5, h, w, h - 50)
      ..lineTo(w, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
