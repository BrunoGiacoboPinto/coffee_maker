// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffee_photo_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoffeePhotoDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoffeePhotoDetailsState()';
}


}

/// @nodoc
class $CoffeePhotoDetailsStateCopyWith<$Res>  {
$CoffeePhotoDetailsStateCopyWith(CoffeePhotoDetailsState _, $Res Function(CoffeePhotoDetailsState) __);
}


/// Adds pattern-matching-related methods to [CoffeePhotoDetailsState].
extension CoffeePhotoDetailsStatePatterns on CoffeePhotoDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CoffeePhotoDetailsInitialState value)?  initial,TResult Function( CoffeePhotoDetailsLoadingState value)?  loading,TResult Function( CoffeePhotoDetailsSuccessState value)?  success,TResult Function( CoffeePhotoDetailsErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState() when initial != null:
return initial(_that);case CoffeePhotoDetailsLoadingState() when loading != null:
return loading(_that);case CoffeePhotoDetailsSuccessState() when success != null:
return success(_that);case CoffeePhotoDetailsErrorState() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CoffeePhotoDetailsInitialState value)  initial,required TResult Function( CoffeePhotoDetailsLoadingState value)  loading,required TResult Function( CoffeePhotoDetailsSuccessState value)  success,required TResult Function( CoffeePhotoDetailsErrorState value)  error,}){
final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState():
return initial(_that);case CoffeePhotoDetailsLoadingState():
return loading(_that);case CoffeePhotoDetailsSuccessState():
return success(_that);case CoffeePhotoDetailsErrorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CoffeePhotoDetailsInitialState value)?  initial,TResult? Function( CoffeePhotoDetailsLoadingState value)?  loading,TResult? Function( CoffeePhotoDetailsSuccessState value)?  success,TResult? Function( CoffeePhotoDetailsErrorState value)?  error,}){
final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState() when initial != null:
return initial(_that);case CoffeePhotoDetailsLoadingState() when loading != null:
return loading(_that);case CoffeePhotoDetailsSuccessState() when success != null:
return success(_that);case CoffeePhotoDetailsErrorState() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CoffeePhotoData photo)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState() when initial != null:
return initial();case CoffeePhotoDetailsLoadingState() when loading != null:
return loading();case CoffeePhotoDetailsSuccessState() when success != null:
return success(_that.photo);case CoffeePhotoDetailsErrorState() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CoffeePhotoData photo)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState():
return initial();case CoffeePhotoDetailsLoadingState():
return loading();case CoffeePhotoDetailsSuccessState():
return success(_that.photo);case CoffeePhotoDetailsErrorState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CoffeePhotoData photo)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CoffeePhotoDetailsInitialState() when initial != null:
return initial();case CoffeePhotoDetailsLoadingState() when loading != null:
return loading();case CoffeePhotoDetailsSuccessState() when success != null:
return success(_that.photo);case CoffeePhotoDetailsErrorState() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CoffeePhotoDetailsInitialState implements CoffeePhotoDetailsState {
  const CoffeePhotoDetailsInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoffeePhotoDetailsState.initial()';
}


}




/// @nodoc


class CoffeePhotoDetailsLoadingState implements CoffeePhotoDetailsState {
  const CoffeePhotoDetailsLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoffeePhotoDetailsState.loading()';
}


}




/// @nodoc


class CoffeePhotoDetailsSuccessState implements CoffeePhotoDetailsState {
  const CoffeePhotoDetailsSuccessState(this.photo);
  

 final  CoffeePhotoData photo;

/// Create a copy of CoffeePhotoDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeePhotoDetailsSuccessStateCopyWith<CoffeePhotoDetailsSuccessState> get copyWith => _$CoffeePhotoDetailsSuccessStateCopyWithImpl<CoffeePhotoDetailsSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsSuccessState&&(identical(other.photo, photo) || other.photo == photo));
}


@override
int get hashCode => Object.hash(runtimeType,photo);

@override
String toString() {
  return 'CoffeePhotoDetailsState.success(photo: $photo)';
}


}

/// @nodoc
abstract mixin class $CoffeePhotoDetailsSuccessStateCopyWith<$Res> implements $CoffeePhotoDetailsStateCopyWith<$Res> {
  factory $CoffeePhotoDetailsSuccessStateCopyWith(CoffeePhotoDetailsSuccessState value, $Res Function(CoffeePhotoDetailsSuccessState) _then) = _$CoffeePhotoDetailsSuccessStateCopyWithImpl;
@useResult
$Res call({
 CoffeePhotoData photo
});


$CoffeePhotoDataCopyWith<$Res> get photo;

}
/// @nodoc
class _$CoffeePhotoDetailsSuccessStateCopyWithImpl<$Res>
    implements $CoffeePhotoDetailsSuccessStateCopyWith<$Res> {
  _$CoffeePhotoDetailsSuccessStateCopyWithImpl(this._self, this._then);

  final CoffeePhotoDetailsSuccessState _self;
  final $Res Function(CoffeePhotoDetailsSuccessState) _then;

/// Create a copy of CoffeePhotoDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photo = null,}) {
  return _then(CoffeePhotoDetailsSuccessState(
null == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as CoffeePhotoData,
  ));
}

/// Create a copy of CoffeePhotoDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoffeePhotoDataCopyWith<$Res> get photo {
  
  return $CoffeePhotoDataCopyWith<$Res>(_self.photo, (value) {
    return _then(_self.copyWith(photo: value));
  });
}
}

/// @nodoc


class CoffeePhotoDetailsErrorState implements CoffeePhotoDetailsState {
  const CoffeePhotoDetailsErrorState(this.message);
  

 final  String message;

/// Create a copy of CoffeePhotoDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoffeePhotoDetailsErrorStateCopyWith<CoffeePhotoDetailsErrorState> get copyWith => _$CoffeePhotoDetailsErrorStateCopyWithImpl<CoffeePhotoDetailsErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoffeePhotoDetailsErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CoffeePhotoDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CoffeePhotoDetailsErrorStateCopyWith<$Res> implements $CoffeePhotoDetailsStateCopyWith<$Res> {
  factory $CoffeePhotoDetailsErrorStateCopyWith(CoffeePhotoDetailsErrorState value, $Res Function(CoffeePhotoDetailsErrorState) _then) = _$CoffeePhotoDetailsErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CoffeePhotoDetailsErrorStateCopyWithImpl<$Res>
    implements $CoffeePhotoDetailsErrorStateCopyWith<$Res> {
  _$CoffeePhotoDetailsErrorStateCopyWithImpl(this._self, this._then);

  final CoffeePhotoDetailsErrorState _self;
  final $Res Function(CoffeePhotoDetailsErrorState) _then;

/// Create a copy of CoffeePhotoDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CoffeePhotoDetailsErrorState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
