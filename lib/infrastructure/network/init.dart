// import 'package:allgood/infrastructure/base_urls.dart';
// import 'package:allgood/infrastructure/globals.dart';
// import 'package:allgood/infrastructure/network/interceptor.dart';
// import 'package:chucker_flutter/chucker_flutter.dart';
// import 'package:dio_smart_retry/dio_smart_retry.dart';
// import 'package:flutter/foundation.dart';

// void initNetworkConfig() {
//   dio.interceptors.addAll([
//     DioInterceptor(),
//     ChuckerDioInterceptor(),

//     RetryInterceptor(
//       dio: dio,
//       logPrint: debugPrint, 
      
//       retries: 3, // retry count (optional)

//       retryDelays: const [
//         // set delays between retries (optional)
//         Duration(seconds: 1), // wait 1 sec before first retry
//         Duration(seconds: 2), // wait 2 sec before second retry
//         Duration(seconds: 3), // wait 3 sec before third retry
//       ],
      
//     )
//   ]);

//   dio.options.baseUrl = kDebugMode ? BaseUrl.devUrl : BaseUrl.prodUrl;

//   dio.options.connectTimeout = const Duration(seconds: 30);
//   dio.options.receiveTimeout = const Duration(seconds: 30);
//   dio.options.sendTimeout = const Duration(seconds: 50);
// }
