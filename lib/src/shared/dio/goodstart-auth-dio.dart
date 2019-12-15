import 'package:dio/dio.dart';

import 'interceptors/authorization-interceptor.dart';
abstract class ICustomDio {
  get dio;
}

// This dio lets you add your custom interceptors through the constructor
class CustomDio implements ICustomDio{
  final _dio = Dio(BaseOptions(
      baseUrl: "https://trekkers.sevenclicks.us/api/",
    ));
  final List<Interceptor> _interceptors;
  get dio => _dio;
  
  CustomDio(this._interceptors){
    _interceptors.forEach((interceptor) => _dio.interceptors.add(interceptor));
  }
}

// Use this dio to always have an Access Token (it has the AuthorizationInterceptor)
class GoodstartAuthDio implements ICustomDio{
  
  final _dio = Dio(BaseOptions(
      baseUrl: "https://trekkers.sevenclicks.us/api/",
    ));

  final List<Interceptor> _interceptors = [AuthrizationInterceptor()];
  
  get dio => _dio;
  
  GoodstartAuthDio(){
    _interceptors.forEach((interceptor) => _dio.interceptors.add(interceptor));
  }
}