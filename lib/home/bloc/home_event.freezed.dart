// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchPhotosEvent value)?  fetchPhotos,TResult Function( ToggleFavoriteEvent value)?  toggleFavorite,TResult Function( PhotosUpdatedEvent value)?  photosUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchPhotosEvent() when fetchPhotos != null:
return fetchPhotos(_that);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that);case PhotosUpdatedEvent() when photosUpdated != null:
return photosUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchPhotosEvent value)  fetchPhotos,required TResult Function( ToggleFavoriteEvent value)  toggleFavorite,required TResult Function( PhotosUpdatedEvent value)  photosUpdated,}){
final _that = this;
switch (_that) {
case FetchPhotosEvent():
return fetchPhotos(_that);case ToggleFavoriteEvent():
return toggleFavorite(_that);case PhotosUpdatedEvent():
return photosUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchPhotosEvent value)?  fetchPhotos,TResult? Function( ToggleFavoriteEvent value)?  toggleFavorite,TResult? Function( PhotosUpdatedEvent value)?  photosUpdated,}){
final _that = this;
switch (_that) {
case FetchPhotosEvent() when fetchPhotos != null:
return fetchPhotos(_that);case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that);case PhotosUpdatedEvent() when photosUpdated != null:
return photosUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchPhotos,TResult Function( String id)?  toggleFavorite,TResult Function( List<CoffeePhotoData> photos)?  photosUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchPhotosEvent() when fetchPhotos != null:
return fetchPhotos();case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that.id);case PhotosUpdatedEvent() when photosUpdated != null:
return photosUpdated(_that.photos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchPhotos,required TResult Function( String id)  toggleFavorite,required TResult Function( List<CoffeePhotoData> photos)  photosUpdated,}) {final _that = this;
switch (_that) {
case FetchPhotosEvent():
return fetchPhotos();case ToggleFavoriteEvent():
return toggleFavorite(_that.id);case PhotosUpdatedEvent():
return photosUpdated(_that.photos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchPhotos,TResult? Function( String id)?  toggleFavorite,TResult? Function( List<CoffeePhotoData> photos)?  photosUpdated,}) {final _that = this;
switch (_that) {
case FetchPhotosEvent() when fetchPhotos != null:
return fetchPhotos();case ToggleFavoriteEvent() when toggleFavorite != null:
return toggleFavorite(_that.id);case PhotosUpdatedEvent() when photosUpdated != null:
return photosUpdated(_that.photos);case _:
  return null;

}
}

}

/// @nodoc


class FetchPhotosEvent implements HomeEvent {
  const FetchPhotosEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchPhotosEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.fetchPhotos()';
}


}




/// @nodoc


class ToggleFavoriteEvent implements HomeEvent {
  const ToggleFavoriteEvent(this.id);
  

 final  String id;

/// Create a copy of HomeEvent
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
  return 'HomeEvent.toggleFavorite(id: $id)';
}


}

/// @nodoc
abstract mixin class $ToggleFavoriteEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
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

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ToggleFavoriteEvent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PhotosUpdatedEvent implements HomeEvent {
  const PhotosUpdatedEvent(final  List<CoffeePhotoData> photos): _photos = photos;
  

 final  List<CoffeePhotoData> _photos;
 List<CoffeePhotoData> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotosUpdatedEventCopyWith<PhotosUpdatedEvent> get copyWith => _$PhotosUpdatedEventCopyWithImpl<PhotosUpdatedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotosUpdatedEvent&&const DeepCollectionEquality().equals(other._photos, _photos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'HomeEvent.photosUpdated(photos: $photos)';
}


}

/// @nodoc
abstract mixin class $PhotosUpdatedEventCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $PhotosUpdatedEventCopyWith(PhotosUpdatedEvent value, $Res Function(PhotosUpdatedEvent) _then) = _$PhotosUpdatedEventCopyWithImpl;
@useResult
$Res call({
 List<CoffeePhotoData> photos
});




}
/// @nodoc
class _$PhotosUpdatedEventCopyWithImpl<$Res>
    implements $PhotosUpdatedEventCopyWith<$Res> {
  _$PhotosUpdatedEventCopyWithImpl(this._self, this._then);

  final PhotosUpdatedEvent _self;
  final $Res Function(PhotosUpdatedEvent) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photos = null,}) {
  return _then(PhotosUpdatedEvent(
null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<CoffeePhotoData>,
  ));
}


}

// dart format on
