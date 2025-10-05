// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_photo_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoffeePhotoDetailsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoffeePhotoDetailsEvent()';
}


}

/// @nodoc
class $CoffeePhotoDetailsEventCopyWith<$Res>  {
$CoffeePhotoDetailsEventCopyWith(CoffeePhotoDetailsEvent _, $Res Function(CoffeePhotoDetailsEvent) __);
}


/// Adds pattern-matching-related methods to [CoffeePhotoDetailsEvent].
extension CoffeePhotoDetailsEventPatterns on CoffeePhotoDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchPhotoEvent value)?  fetchPhoto,TResult Function( ToggleFavoriteEvent value)?  toggleFavorite,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchPhotoEvent() when fetchPhoto != null:
return fetchPhoto(_that);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchPhotoEvent value)  fetchPhoto,required TResult Function( ToggleFavoriteEvent value)  toggleFavorite,}){
final _that = this;
switch (_that) {
case FetchPhotoEvent():
return fetchPhoto(_that);case ToggleFavoriteEvent():
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchPhotoEvent value)?  fetchPhoto,TResult? Function( ToggleFavoriteEvent value)?  toggleFavorite,}){
final _that = this;
switch (_that) {
case FetchPhotoEvent() when fetchPhoto != null:
return fetchPhoto(_that);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String photoId)?  fetchPhoto,TResult Function( String id)?  toggleFavorite,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchPhotoEvent() when fetchPhoto != null:
return fetchPhoto(_that.photoId);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String photoId)  fetchPhoto,required TResult Function( String id)  toggleFavorite,}) {final _that = this;
switch (_that) {
case FetchPhotoEvent():
return fetchPhoto(_that.photoId);case ToggleFavoriteEvent():
return toggleFavorite(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String photoId)?  fetchPhoto,TResult? Function( String id)?  toggleFavorite,}) {final _that = this;
switch (_that) {
case FetchPhotoEvent() when fetchPhoto != null:
return fetchPhoto(_that.photoId);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class FetchPhotoEvent implements CoffeePhotoDetailsEvent {
  const FetchPhotoEvent(this.photoId);
  

 final  String photoId;

/// Create a copy of CoffeePhotoDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchPhotoEventCopyWith<FetchPhotoEvent> get copyWith => _$FetchPhotoEventCopyWithImpl<FetchPhotoEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchPhotoEvent&&(identical(other.photoId, photoId) || other.photoId == photoId));
}


@override
int get hashCode => Object.hash(runtimeType,photoId);

@override
String toString() {
  return 'CoffeePhotoDetailsEvent.fetchPhoto(photoId: $photoId)';
}


}

/// @nodoc
abstract mixin class $FetchPhotoEventCopyWith<$Res> implements $CoffeePhotoDetailsEventCopyWith<$Res> {
  factory $FetchPhotoEventCopyWith(FetchPhotoEvent value, $Res Function(FetchPhotoEvent) _then) = _$FetchPhotoEventCopyWithImpl;
@useResult
$Res call({
 String photoId
});




}
/// @nodoc
class _$FetchPhotoEventCopyWithImpl<$Res>
    implements $FetchPhotoEventCopyWith<$Res> {
  _$FetchPhotoEventCopyWithImpl(this._self, this._then);

  final FetchPhotoEvent _self;
  final $Res Function(FetchPhotoEvent) _then;

/// Create a copy of CoffeePhotoDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photoId = null,}) {
  return _then(FetchPhotoEvent(
null == photoId ? _self.photoId : photoId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToggleFavoriteEvent implements CoffeePhotoDetailsEvent {
  const ToggleFavoriteEvent(this.id);
  

 final  String id;

/// Create a copy of CoffeePhotoDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleFavoriteEventCopyWith<ToggleFavoriteEvent> get copyWith => _$ToggleFavoriteEventCopyWithImpl<ToggleFavoriteEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleFavoriteEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CoffeePhotoDetailsEvent.toggleFavorite(id: $id)';
}


}

/// @nodoc
abstract mixin class $ToggleFavoriteEventCopyWith<$Res> implements $CoffeePhotoDetailsEventCopyWith<$Res> {
  factory $ToggleFavoriteEventCopyWith(ToggleFavoriteEvent value, $Res Function(ToggleFavoriteEvent) _then) = _$ToggleFavoriteEventCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ToggleFavoriteEventCopyWithImpl<$Res>
    implements $ToggleFavoriteEventCopyWith<$Res> {
  _$ToggleFavoriteEventCopyWithImpl(this._self, this._then);

  final ToggleFavoriteEvent _self;
  final $Res Function(ToggleFavoriteEvent) _then;

/// Create a copy of CoffeePhotoDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ToggleFavoriteEvent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
