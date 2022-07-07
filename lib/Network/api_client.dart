import 'package:dart_news/Models/EverythingResponse.dart';
import 'package:dart_news/Models/HeadlinesResponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://newsapi.org/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('v2/top-headlines')
  Future<HeadlinesResponse> getHeadlines(
      @Query("country") String country,
      @Query("apiKey") String apiKey
      );

  @GET('v2/everything')
  Future<EverythingResponse> getEverything(
      @Query("q") String q,
      @Query("apiKey") String apiKey,
      );
}