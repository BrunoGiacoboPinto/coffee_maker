// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState()';
}


}

/// @nodoc
class $FavoritesStateCopyWith<$Res>  {
$FavoritesStateCopyWith(FavoritesState _, $Res Function(FavoritesState) __);
}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FavoritesInitialState value)?  initial,TResult Function( FavoritesLoadingState value)?  loading,TResult Function( FavoritesSuccessState value)?  success,TResult Function( FavoritesErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FavoritesInitialState() when initial != null:
return initial(_that);case FavoritesLoadingState() when loading != null:
return loading(_that);case FavoritesSuccessState() when success != null:
return success(_that);case FavoritesErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FavoritesInitialState value)  initial,required TResult Function( FavoritesLoadingState value)  loading,required TResult Function( FavoritesSuccessState value)  success,required TResult Function( FavoritesErrorState value)  error,}){
final _that = this;
switch (_that) {
case FavoritesInitialState():
return initial(_that);case FavoritesLoadingState():
return loading(_that);case FavoritesSuccessState():
return success(_that);case FavoritesErrorState():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FavoritesInitialState value)?  initial,TResult? Function( FavoritesLoadingState value)?  loading,TResult? Function( FavoritesSuccessState value)?  success,TResult? Function( FavoritesErrorState value)?  error,}){
final _that = this;
switch (_that) {
case FavoritesInitialState() when initial != null:
return initial(_that);case FavoritesLoadingState() when loading != null:
return loading(_that);case FavoritesSuccessState() when success != null:
return success(_that);case FavoritesErrorState() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CoffeePhotoData> photos)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FavoritesInitialState() when initial != null:
return initial();case FavoritesLoadingState() when loading != null:
return loading();case FavoritesSuccessState() when success != null:
return success(_that.photos);case FavoritesErrorState() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CoffeePhotoData> photos)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case FavoritesInitialState():
return initial();case FavoritesLoadingState():
return loading();case FavoritesSuccessState():
return success(_that.photos);case FavoritesErrorState():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CoffeePhotoData> photos)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case FavoritesInitialState() when initial != null:
return initial();case FavoritesLoadingState() when loading != null:
return loading();case FavoritesSuccessState() when success != null:
return success(_that.photos);case FavoritesErrorState() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FavoritesInitialState implements FavoritesState {
  const FavoritesInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState.initial()';
}


}




/// @nodoc


class FavoritesLoadingState implements FavoritesState {
  const FavoritesLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState.loading()';
}


}




/// @nodoc


class FavoritesSuccessState implements FavoritesState {
  const FavoritesSuccessState(final  List<CoffeePhotoData> photos): _photos = photos;
  

 final  List<CoffeePhotoData> _photos;
 List<CoffeePhotoData> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}


/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesSuccessStateCopyWith<FavoritesSuccessState> get copyWith => _$FavoritesSuccessStateCopyWithImpl<FavoritesSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesSuccessState&&const DeepCollectionEquality().equals(other._photos, _photos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_photos));

@override
String toString() {
  return 'FavoritesState.success(photos: $photos)';
}


}

/// @nodoc
abstract mixin class $FavoritesSuccessStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory $FavoritesSuccessStateCopyWith(FavoritesSuccessState value, $Res Function(FavoritesSuccessState) _then) = _$FavoritesSuccessStateCopyWithImpl;
@useResult
$Res call({
 List<CoffeePhotoData> photos
});




}
/// @nodoc
class _$FavoritesSuccessStateCopyWithImpl<$Res>
    implements $FavoritesSuccessStateCopyWith<$Res> {
  _$FavoritesSuccessStateCopyWithImpl(this._self, this._then);

  final FavoritesSuccessState _self;
  final $Res Function(FavoritesSuccessState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photos = null,}) {
  return _then(FavoritesSuccessState(
null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<CoffeePhotoData>,
  ));
}


}

/// @nodoc


class FavoritesErrorState implements FavoritesState {
  const FavoritesErrorState(this.message);
  

 final  String message;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesErrorStateCopyWith<FavoritesErrorState> get copyWith => _$FavoritesErrorStateCopyWithImpl<FavoritesErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FavoritesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FavoritesErrorStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory $FavoritesErrorStateCopyWith(FavoritesErrorState value, $Res Function(FavoritesErrorState) _then) = _$FavoritesErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FavoritesErrorStateCopyWithImpl<$Res>
    implements $FavoritesErrorStateCopyWith<$Res> {
  _$FavoritesErrorStateCopyWithImpl(this._self, this._then);

  final FavoritesErrorState _self;
  final $Res Function(FavoritesErrorState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FavoritesErrorState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
