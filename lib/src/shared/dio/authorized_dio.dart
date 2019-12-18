import 'package:dio/dio.dart';
import 'package:good_start/src/shared/dio/Icustom_dio.dart';
import 'package:good_start/src/shared/dio/interceptors/authorization_interceptor.dart';


// Use this dio to always have an Access Token (it has the AuthorizationInterceptor)
class AuthorizedDio implements ICustomDio{
  
  final _dio = Dio();

  String get authUrl => "https://706ba35c.ngrok.io/";

  String get hasuraUrl => "https://good-start.herokuapp.com/v1/graphql";

  final List<Interceptor> _interceptors = [AuthrizationInterceptor()];
  
  get dio => _dio;
  
  AuthorizedDio(){
    _interceptors.forEach((interceptor) => _dio.interceptors.add(interceptor));
  }
}