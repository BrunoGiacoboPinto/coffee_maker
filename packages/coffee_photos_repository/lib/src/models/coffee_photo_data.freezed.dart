// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_photo_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoffeePhotoData {

/// The URL of the coffee photo
 String get url;/// The ID of the coffee photo
 String get id;/// Whether the photo is a favorite
 bool get isFavorite;
/// Create a copy of CoffeePhotoData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeePhotoDataCopyWith<CoffeePhotoData> get copyWith => _$CoffeePhotoDataCopyWithImpl<CoffeePhotoData>(this as CoffeePhotoData, _$identity);

  /// Serializes this CoffeePhotoData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoData&&(identical(other.url, url) || other.url == url)&&(identical(other.id, id) || other.id == id)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,id,isFavorite);

@override
String toString() {
  return 'CoffeePhotoData(url: $url, id: $id, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $CoffeePhotoDataCopyWith<$Res>  {
  factory $CoffeePhotoDataCopyWith(CoffeePhotoData value, $Res Function(CoffeePhotoData) _then) = _$CoffeePhotoDataCopyWithImpl;
@useResult
$Res call({
 String url, String id, bool isFavorite
});




}
/// @nodoc
class _$CoffeePhotoDataCopyWithImpl<$Res>
    implements $CoffeePhotoDataCopyWith<$Res> {
  _$CoffeePhotoDataCopyWithImpl(this._self, this._then);

  final CoffeePhotoData _self;
  final $Res Function(CoffeePhotoData) _then;

/// Create a copy of CoffeePhotoData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? id = null,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CoffeePhotoData].
extension CoffeePhotoDataPatterns on CoffeePhotoData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoffeePhotoData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoffeePhotoData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoffeePhotoData value)  $default,){
final _that = this;
switch (_that) {
case _CoffeePhotoData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoffeePhotoData value)?  $default,){
final _that = this;
switch (_that) {
case _CoffeePhotoData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String id,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoffeePhotoData() when $default != null:
return $default(_that.url,_that.id,_that.isFavorite);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String id,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _CoffeePhotoData():
return $default(_that.url,_that.id,_that.isFavorite);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String id,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _CoffeePhotoData() when $default != null:
return $default(_that.url,_that.id,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoffeePhotoData implements CoffeePhotoData {
  const _CoffeePhotoData({required this.url, required this.id, required this.isFavorite});
  factory _CoffeePhotoData.fromJson(Map<String, dynamic> json) => _$CoffeePhotoDataFromJson(json);

/// The URL of the coffee photo
@override final  String url;
/// The ID of the coffee photo
@override final  String id;
/// Whether the photo is a favorite
@override final  bool isFavorite;

/// Create a copy of CoffeePhotoData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoffeePhotoDataCopyWith<_CoffeePhotoData> get copyWith => __$CoffeePhotoDataCopyWithImpl<_CoffeePhotoData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoffeePhotoDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoffeePhotoData&&(identical(other.url, url) || other.url == url)&&(identical(other.id, id) || other.id == id)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,id,isFavorite);

@override
String toString() {
  return 'CoffeePhotoData(url: $url, id: $id, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$CoffeePhotoDataCopyWith<$Res> implements $CoffeePhotoDataCopyWith<$Res> {
  factory _$CoffeePhotoDataCopyWith(_CoffeePhotoData value, $Res Function(_CoffeePhotoData) _then) = __$CoffeePhotoDataCopyWithImpl;
@override @useResult
$Res call({
 String url, String id, bool isFavorite
});




}
/// @nodoc
class __$CoffeePhotoDataCopyWithImpl<$Res>
    implements _$CoffeePhotoDataCopyWith<$Res> {
  __$CoffeePhotoDataCopyWithImpl(this._self, this._then);

  final _CoffeePhotoData _self;
  final $Res Function(_CoffeePhotoData) _then;

/// Create a copy of CoffeePhotoData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? id = null,Object? isFavorite = null,}) {
  return _then(_CoffeePhotoData(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
