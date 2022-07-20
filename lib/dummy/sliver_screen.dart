import 'package:flutter/material.dart';

class SliverScreen extends StatefulWidget {
  const SliverScreen({Key? key}) : super(key: key);

  @override
  _SliverScreenState createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {
  NestedScrollView nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                "Collapsing AppBar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Container(
                color: Colors.blue,
              ),
              /* background: Image.asset( */
              /*   "images/parrot.jpg", */
              /*   fit: BoxFit.cover, */
              /* ), */
            ),
          )
        ];
      },
      body: const Center(
        child: Text("The Parrot"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: custom(),
      // body: nested(),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'My Digital',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ],
          ),
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.blue,
              child: const Center(child: Text('fooo')),
            ),
          ),
        ),
        listItems(),
      ],
    );
  }

  SliverList listItems() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Text('fooo $index'),
        childCount: 50,
      ),
    );
  }
}
