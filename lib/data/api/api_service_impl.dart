import 'dart:async';
import 'dart:convert';

import 'package:flutter_crypto_otc/data/api/api_service.dart';
import 'package:flutter_crypto_otc/data/model.dart';
import 'package:http/http.dart';

class ApiServiceImpl implements ApiService {

  static const GANK_OTC_USDT_PATH = "https://gate.io/json_svr/query_push?type=push_main_rates&symbol=USDT_CNY";
  static const GANK_TICKER_BTC_PATH = "http://data.gate.io/api2/1/ticker/btc_usdt";
  static const HUOBI_OTC_USDT_PATH = "https://api-otc.huobi.pro/v1/otc/trade/list/public?coinId=2&tradeType=1&currentPage=1&online=1&range=0";
  static const HUOBI_OTC_BTC_PATH = "https://api-otc.huobi.pro/v1/otc/trade/list/public?coinId=1&tradeType=1&currentPage=1&online=1&range=0";
  static const ZB_BTC_TICKER_PATH = "http://api.zb.com/data/v1/ticker?market=btc_qc";

  //    usdt: https://gate.io/json_svr/query_push?type=push_main_rates&symbol=USDT_CNY
  @override
  Future<OtcPrice> getGankOtcUsdtPrice() async {
    var response = await get(GANK_OTC_USDT_PATH);
    Map decoded = new JsonDecoder(null).convert(response.body);

    return new OtcPrice("gank.io",
        double.parse(decoded["appraised_rates"]["buy_rate"] as String));
  }

  @override
  Future<OtcPrice> getGankOtcUsdtBtcPrice() async {
    var otcUsdtResponse = await get(GANK_OTC_USDT_PATH);
    Map otcUsdtDecoded = new JsonDecoder(null).convert(otcUsdtResponse.body);
    num otcUsdtPrice = double.parse(
        otcUsdtDecoded["appraised_rates"]["buy_rate"] as String);

    var btcTickerResponse = await get(GANK_TICKER_BTC_PATH);
    Map btcTickerDecoded = new JsonDecoder(null).convert(
        btcTickerResponse.body);

    num btcTickerPrice = btcTickerDecoded["last"];

    return new OtcPrice("gank.io", otcUsdtPrice * btcTickerPrice);
  }

  // usdt:   https://api-otc.huobi.pro/v1/otc/trade/list/public?coinId=2&tradeType=1&currentPage=1&online=1&range=0
  @override
  Future<OtcPrice> getHuobiOtcBtcPrice() async {
    var response = await get(HUOBI_OTC_BTC_PATH);
    Map decoded = new JsonDecoder(null).convert(response.body);
    return new OtcPrice("huobi.pro", decoded["data"][0]["price"]);
  }

  // usdt:   https://api-otc.huobi.pro/v1/otc/trade/list/public?coinId=2&tradeType=1&currentPage=1&online=1&range=0
  @override
  Future<OtcPrice> getHuobiOtcUsdtPrice() async {
    var response = await get(HUOBI_OTC_USDT_PATH);
    Map decoded = new JsonDecoder(null).convert(response.body);
    return new OtcPrice("huobi.pro", decoded["data"][0]["price"]);
  }

//  http://api.zb.com/data/v1/ticker?market=btc_usdt
  @override
  Future<OtcPrice> getZbOtcQcBtcPrice() async {
    var response = await get(ZB_BTC_TICKER_PATH);
    Map decoded = new JsonDecoder(null).convert(response.body);
    return new OtcPrice("zb.com",
        double.parse(decoded["ticker"]["last"] as String));
  }
}