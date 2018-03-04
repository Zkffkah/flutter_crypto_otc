import 'package:flutter/material.dart';

class PriceItemView extends StatelessWidget {
  PriceItemView({
    this.label,
    this.price,
  });

  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: new Container(
            decoration: new BoxDecoration(),
            padding: new EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(label, textAlign: TextAlign.center),
                ),
                new Expanded(
                  child: new Text(price, textAlign: TextAlign.center),
                ),
              ],
            )));
  }
}
