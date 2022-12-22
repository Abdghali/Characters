import 'package:crac_app/constance/strings.dart';
import 'package:crac_app/data/models/characters.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/episode.dart';

class CharacterServices {
  late Dio dio;
  CharacterServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);

    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print("response ${response.data.toString()}");
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> getCharacterEpisode(String episodeUrl) async {
    try {
      int episodeId = int.parse(episodeUrl.split('/').last);
      Response response = await dio.get('episode/$episodeId');
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
