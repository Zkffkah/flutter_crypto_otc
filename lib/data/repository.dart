import 'package:flutter_crypto_otc/data/api/api_service.dart';
import 'package:flutter_crypto_otc/data/api/api_service_impl.dart';

class ApiServiceFactory {
  static final ApiServiceFactory _singleton = new ApiServiceFactory._internal();

  factory ApiServiceFactory() {
    return _singleton;
  }

  ApiService _api;

  ApiServiceFactory._internal() {
    _api = new ApiServiceImpl();
  }

  static ApiService getApiService() {
    return _singleton._api;
  }


}
