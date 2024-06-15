import 'package:dio/dio.dart';
import 'package:web_redrop/data/network/logger/pretty_dio_logger.dart';
import 'package:web_redrop/package/config_packages.dart';

late Dio dio;
String  proxy="";

BaseOptions baseOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30));


 String baseUrl = "";

Future<void> dioSetUp({int? language}) async {
  dio = Dio(baseOptions);

  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions option, RequestInterceptorHandler handler) async {
    var customHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'VerifyMe': '',
    };
    option.headers.addAll(customHeaders);
    handler.next(option);
  }));

  /// PreDioLogger to print api log in DEBUG mode
  if (!kReleaseMode) {
    var logger = PrettyDioLogger(
      maxWidth: 232,
      requestHeader: true,
      requestBody: true,
    );
    dio.interceptors.add(logger);
  }

  dio.options.baseUrl = baseUrl;
}
