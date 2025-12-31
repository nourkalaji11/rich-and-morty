import 'package:dio/dio.dart';
import 'package:rick_and_morty/constant/strings.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>?> getAllCharacter() async {
    try {
      Response response = await dio.get('character');
      return response.data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
