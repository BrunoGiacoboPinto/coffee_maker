// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_photo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoffeePhotoData _$CoffeePhotoDataFromJson(Map<String, dynamic> json) =>
    _CoffeePhotoData(
      url: json['url'] as String,
      id: json['id'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$CoffeePhotoDataToJson(_CoffeePhotoData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'isFavorite': instance.isFavorite,
    };
