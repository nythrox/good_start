import 'package:dio/dio.dart';

abstract class ICustomDio {
  Dio get dio;
  final String hasuraUrl;
  final String authUrl;

  ICustomDio(this.hasuraUrl, this.authUrl);
}
