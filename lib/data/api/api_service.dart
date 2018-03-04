import 'dart:async';

import 'package:flutter_crypto_otc/data/model.dart';

abstract class ApiService {


  Future<OtcPrice> getHuobiOtcBtcPrice();

  Future<OtcPrice> getHuobiOtcUsdtPrice();

  Future<OtcPrice> getGankOtcUsdtPrice();

  Future<OtcPrice> getGankOtcUsdtBtcPrice();

  Future<OtcPrice> getZbOtcQcBtcPrice();

}