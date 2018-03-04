import 'package:flutter/material.dart';
import 'package:flutter_crypto_otc/ui/btc/btc.dart';
import 'package:flutter_crypto_otc/ui/usdt/usdt.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

final List<Tab> mainTabs = <Tab>[
  new Tab(text: 'BTC'),
  new Tab(text: 'USDT'),
];

class _HomePageState extends State<HomePage> {


  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
      new DefaultTabController(
          length: mainTabs.length,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title),
              bottom: new TabBar(
                  tabs: mainTabs
              ),
            ),
            body: new TabBarView(
              children: mainTabs.map((Tab tab) {
                switch (tab.text) {
                  case"BTC":
                    return new BtcPage();
                    break;
                  case "USDT" :
                    return new UsdtPage();
                    break;
                  default:
                    return new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Center(
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    tab.text,
                                  ),
                                ]))
                    );
                }
              }).toList(),
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ));
  }
}