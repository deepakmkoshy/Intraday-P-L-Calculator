import 'package:flutter/material.dart';
import 'package:intradaypl/screens/percentage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

 

  

  

  

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
        appBar: AppBar(
          title: Text('Intraday P&L Calculator'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Percentage')
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timeline_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Target')
                  ],
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Color(0XFF0043b4),
        ),
        backgroundColor: Colors.grey[100],

        //Wrapping with gesture detector to hide keyboard
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Percentage(),
            Container(
              child: Center(
                child: Text("New"),
              ),
            )
          ],
        ));
  }
}
