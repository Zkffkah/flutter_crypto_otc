import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crypto_otc/data/model.dart';
import 'package:flutter_crypto_otc/data/repository.dart';
import 'package:flutter_crypto_otc/ui/price_item_view.dart';
import 'package:rxdart/rxdart.dart';


class BtcPage extends StatefulWidget {

  @override
  State createState() => new _BtcPageState();
}


class _BtcPageState extends State<BtcPage> {
  StreamSubscription _sub;
  List<OtcPrice> _otcPrices = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<
      RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    final load = new Future<Null>.value(null);
    load.then((_) {
      _refreshIndicatorKey.currentState.show();
      getData();
    });
  }

  getData() {
    _sub = Observable.zip3(
        ApiServiceFactory.getApiService()
            .getHuobiOtcBtcPrice().asStream(),
        ApiServiceFactory.getApiService()
            .getGankOtcUsdtBtcPrice().asStream(),
        ApiServiceFactory.getApiService()
            .getZbOtcQcBtcPrice().asStream(),
            (a, b, c) => [a, b, c])
        .listen((prices) {
      if (mounted) {
        setState(() {
          _otcPrices = prices;
        }
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: new ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: _otcPrices.map((otcPrice) =>
            new PriceItemView(
                label: otcPrice.name, price: otcPrice.price.toString()))
                .toList()
        ));
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 3), () {
      completer.complete(null);
    });
    return completer.future.then((_) {
      getData();
    });
  }

  /// Cancel the subscription.
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

}
