import 'package:dio/dio.dart';
import 'apiendpoint.dart';

class DioClient
{
   DioClient._();
  static DioClient dioClient = DioClient._();
  static Dio dio = Dio();

  BaseOptions baseUrl = BaseOptions(baseUrl: ApiEndPoint.baseUrl);

  Future<Response> getAPI({required  String endPoint})async
  {
    dio.options = baseUrl;
    return dio.get(endPoint);
  }


}