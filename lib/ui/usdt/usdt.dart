import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crypto_otc/data/model.dart';
import 'package:flutter_crypto_otc/data/repository.dart';
import 'package:flutter_crypto_otc/ui/price_item_view.dart';
import 'package:rxdart/rxdart.dart';

class UsdtPage extends StatefulWidget {

  @override
  State createState() => new _UsdtPageState();
}


class _UsdtPageState extends State<UsdtPage> {
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
    _sub = Observable.zip2(
        ApiServiceFactory.getApiService()
            .getGankOtcUsdtPrice().asStream(),
        ApiServiceFactory.getApiService()
            .getHuobiOtcUsdtPrice().asStream(),
            (a, b) => [a, b])
        .listen((prices) {
//      https://docs.flutter.io/flutter/widgets/State/setState.html
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

  /// Cancel the store subscription.
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
