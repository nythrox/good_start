import 'package:dio/dio.dart';
import 'package:good_start/src/shared/dio/Icustom_dio.dart';


// This dio lets you add your custom interceptors through the constructor
class CustomDio implements ICustomDio{
  final _dio = Dio();
    
  String get authUrl => "http://192.168.99.100:7000/";

  String get hasuraUrl => "https://good-start.herokuapp.com/v1/graphql";

  final List<Interceptor> _interceptors;
  
  get dio => _dio;
  
  CustomDio(this._interceptors){
    _interceptors.forEach((interceptor) => _dio.interceptors.add(interceptor));
  }
}
