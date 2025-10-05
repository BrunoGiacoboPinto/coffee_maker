import 'package:coffee_photos_repository/src/models/coffee_photo_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'coffee_photos_service.g.dart';

/// Service for fetching coffee photos from the API
@RestApi()
// This abstract class is required by Retrofit for code generation
// ignore: one_member_abstracts
abstract class CoffeePhotosService {
  /// Creates a new instance of [CoffeePhotosService]
  factory CoffeePhotosService(Dio dio, {String? baseUrl}) =
      _CoffeePhotosService;

  /// Fetches a list of random coffee photos
  @GET('/random.json')
  Future<CoffeePhotoResponse> getCoffeePhotos();
}
