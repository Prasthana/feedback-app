
import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/post.dart';
import 'package:retrofit/http.dart';
part 'api_services.g.dart';
 
@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/posts")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("")
  Future<List<Post>> getPost();
}