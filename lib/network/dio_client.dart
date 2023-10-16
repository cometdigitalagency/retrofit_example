import 'package:dio/dio.dart';

class DioClient {
  Dio instance() {
    Dio dio = Dio();
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.options.baseUrl = 'https://jsonplaceholder.typicode.com/';
    // add tokenInterceptor() ໃຫ້ກັບ Dio
    dio.interceptors.addAll([tokenInterceptor(), refreshTokenInterceptor(dio)]);
    return dio;
  }

  InterceptorsWrapper tokenInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await getToken();
      options.headers = {'Authorization': 'Bearer $token'};
      return handler.next(options);
    });
  }

  InterceptorsWrapper refreshTokenInterceptor(Dio dio) {
    return InterceptorsWrapper(onError: (err, handler) async {
      if (err.response?.statusCode == 403) {
        // ຖ້າໄດ້ຮັບ response ເປັນ 403, ໃຫ້ refresh token
        String newAccessToken = await refreshToken();

        // Update header ຂອງ request ດ້ວຍ token ອັນໃໝ່
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // Repeat the request with the updated header
        // ສົ່ງ request ໄປໃໝ່ ໂດຍໃຊ້ header ທີ່ຖືກອັບເດດ.
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
      return handler.next(err);
    });
  }
}

Future<String> getToken() {
  return Future.value('your_access_token');
}

Future<String> refreshToken() async {
  return Future.value('your_new_access_token');
}
