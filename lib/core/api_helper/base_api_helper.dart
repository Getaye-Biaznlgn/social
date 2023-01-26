import 'package:church_social_media/core/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiBaseHelper {
  static BaseOptions opts = BaseOptions(
    baseUrl: Urls.kBaseUrl,
    connectTimeout: 5000000,
    receiveTimeout: 5000000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(onRequest:
            // (RequestOptions options, RequestInterceptorHandler handler) =>
            // handler.next(requestInterceptor(options)),
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // if( await sl<LocalStorageService>().getStringFromDisk('token') != null  || await sl<LocalStorageService>().getStringFromDisk('token') == "true"){
          //   options.headers['Authorization'] = 'Bearer ${( await sl<LocalStorageService>().getStringFromDisk('token'))}';
          //   print('here is the token in base Api ${( await sl<LocalStorageService>().getStringFromDisk('token')).toString()}');
          //   return handler.next(options);
          // }else{
          options.headers['Authorization'] = 'No Auth';
          return handler.next(options);

          // }
        }, onError: (DioError e, ErrorInterceptorHandler handler) async {
          return handler.next(e);
        }),
      );
  }
  // static dynamic requestInterceptor(RequestOptions options) async {
  //   // String token = sl<LocalStorageService>().getToken;
  //   // options.headers.addAll({"Authorization": "Bearer: $token"});
  //   // return options;
  //   if(sl<LocalStorageService>().getToken.isNotEmpty  && sl<LocalStorageService>().getToken != ''){
  //     options.headers['Authorization'] = 'Bearer ${sl<LocalStorageService>().getToken}';
  //     return options;
  //   }
  // }

  static final dio = createDio();

  static final baseAPI = addInterceptors(dio);

  Future<Response> getHTTP(String url) async {
    Response? response;
    try {
      response = await baseAPI.get(url);
      return response;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    Response? response;
    try {
      response = await baseAPI.post(url, data: data);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    try {
      Response response = await dio.put(url, data: data);
      return response;
    } on DioError catch (e) {
      print("put HTTP error happen check");
      print(e.message);
    }
  }

  Future<Response?> deleteHTTP(String url) async {
    try {
      Response response = await dio.delete(url);
      return response;
    } on DioError catch (e) {
      // Handle error
      print("delete HTTP error happen check");
      print(e.message);
    }
  }
}
