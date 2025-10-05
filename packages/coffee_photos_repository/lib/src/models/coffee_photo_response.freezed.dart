// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_photo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoffeePhotoResponse {

/// The file path or URL of the coffee photo
 String get file;
/// Create a copy of CoffeePhotoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeePhotoResponseCopyWith<CoffeePhotoResponse> get copyWith => _$CoffeePhotoResponseCopyWithImpl<CoffeePhotoResponse>(this as CoffeePhotoResponse, _$identity);

  /// Serializes this CoffeePhotoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoResponse&&(identical(other.file, file) || other.file == file));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'CoffeePhotoResponse(file: $file)';
}


}

/// @nodoc
abstract mixin class $CoffeePhotoResponseCopyWith<$Res>  {
  factory $CoffeePhotoResponseCopyWith(CoffeePhotoResponse value, $Res Function(CoffeePhotoResponse) _then) = _$CoffeePhotoResponseCopyWithImpl;
@useResult
$Res call({
 String file
});




}
/// @nodoc
class _$CoffeePhotoResponseCopyWithImpl<$Res>
    implements $CoffeePhotoResponseCopyWith<$Res> {
  _$CoffeePhotoResponseCopyWithImpl(this._self, this._then);

  final CoffeePhotoResponse _self;
  final $Res Function(CoffeePhotoResponse) _then;

/// Create a copy of CoffeePhotoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,}) {
  return _then(_self.copyWith(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CoffeePhotoResponse].
extension CoffeePhotoResponsePatterns on CoffeePhotoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoffeePhotoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoffeePhotoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoffeePhotoResponse value)  $default,){
final _that = this;
switch (_that) {
case _CoffeePhotoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoffeePhotoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CoffeePhotoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String file)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoffeePhotoResponse() when $default != null:
return $default(_that.file);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String file)  $default,) {final _that = this;
switch (_that) {
case _CoffeePhotoResponse():
return $default(_that.file);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String file)?  $default,) {final _that = this;
switch (_that) {
case _CoffeePhotoResponse() when $default != null:
return $default(_that.file);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoffeePhotoResponse implements CoffeePhotoResponse {
  const _CoffeePhotoResponse({required this.file});
  factory _CoffeePhotoResponse.fromJson(Map<String, dynamic> json) => _$CoffeePhotoResponseFromJson(json);

/// The file path or URL of the coffee photo
@override final  String file;

/// Create a copy of CoffeePhotoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoffeePhotoResponseCopyWith<_CoffeePhotoResponse> get copyWith => __$CoffeePhotoResponseCopyWithImpl<_CoffeePhotoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoffeePhotoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoffeePhotoResponse&&(identical(other.file, file) || other.file == file));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'CoffeePhotoResponse(file: $file)';
}


}

/// @nodoc
abstract mixin class _$CoffeePhotoResponseCopyWith<$Res> implements $CoffeePhotoResponseCopyWith<$Res> {
  factory _$CoffeePhotoResponseCopyWith(_CoffeePhotoResponse value, $Res Function(_CoffeePhotoResponse) _then) = __$CoffeePhotoResponseCopyWithImpl;
@override @useResult
$Res call({
 String file
});




}
/// @nodoc
class __$CoffeePhotoResponseCopyWithImpl<$Res>
    implements _$CoffeePhotoResponseCopyWith<$Res> {
  __$CoffeePhotoResponseCopyWithImpl(this._self, this._then);

  final _CoffeePhotoResponse _self;
  final $Res Function(_CoffeePhotoResponse) _then;

/// Create a copy of CoffeePhotoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(_CoffeePhotoResponse(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
