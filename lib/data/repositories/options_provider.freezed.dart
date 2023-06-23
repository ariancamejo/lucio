// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'options_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OptionsState {
  DateTime get startFilter => throw _privateConstructorUsedError;
  DateTime get endFilter => throw _privateConstructorUsedError;
  int get daysOfRangeDateProduction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptionsStateCopyWith<OptionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionsStateCopyWith<$Res> {
  factory $OptionsStateCopyWith(
          OptionsState value, $Res Function(OptionsState) then) =
      _$OptionsStateCopyWithImpl<$Res, OptionsState>;
  @useResult
  $Res call(
      {DateTime startFilter,
      DateTime endFilter,
      int daysOfRangeDateProduction});
}

/// @nodoc
class _$OptionsStateCopyWithImpl<$Res, $Val extends OptionsState>
    implements $OptionsStateCopyWith<$Res> {
  _$OptionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startFilter = null,
    Object? endFilter = null,
    Object? daysOfRangeDateProduction = null,
  }) {
    return _then(_value.copyWith(
      startFilter: null == startFilter
          ? _value.startFilter
          : startFilter // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endFilter: null == endFilter
          ? _value.endFilter
          : endFilter // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daysOfRangeDateProduction: null == daysOfRangeDateProduction
          ? _value.daysOfRangeDateProduction
          : daysOfRangeDateProduction // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OptionsStateCopyWith<$Res>
    implements $OptionsStateCopyWith<$Res> {
  factory _$$_OptionsStateCopyWith(
          _$_OptionsState value, $Res Function(_$_OptionsState) then) =
      __$$_OptionsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startFilter,
      DateTime endFilter,
      int daysOfRangeDateProduction});
}

/// @nodoc
class __$$_OptionsStateCopyWithImpl<$Res>
    extends _$OptionsStateCopyWithImpl<$Res, _$_OptionsState>
    implements _$$_OptionsStateCopyWith<$Res> {
  __$$_OptionsStateCopyWithImpl(
      _$_OptionsState _value, $Res Function(_$_OptionsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startFilter = null,
    Object? endFilter = null,
    Object? daysOfRangeDateProduction = null,
  }) {
    return _then(_$_OptionsState(
      startFilter: null == startFilter
          ? _value.startFilter
          : startFilter // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endFilter: null == endFilter
          ? _value.endFilter
          : endFilter // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daysOfRangeDateProduction: null == daysOfRangeDateProduction
          ? _value.daysOfRangeDateProduction
          : daysOfRangeDateProduction // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_OptionsState extends _OptionsState {
  const _$_OptionsState(
      {required this.startFilter,
      required this.endFilter,
      this.daysOfRangeDateProduction = 0})
      : super._();

  @override
  final DateTime startFilter;
  @override
  final DateTime endFilter;
  @override
  @JsonKey()
  final int daysOfRangeDateProduction;

  @override
  String toString() {
    return 'OptionsState(startFilter: $startFilter, endFilter: $endFilter, daysOfRangeDateProduction: $daysOfRangeDateProduction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OptionsState &&
            (identical(other.startFilter, startFilter) ||
                other.startFilter == startFilter) &&
            (identical(other.endFilter, endFilter) ||
                other.endFilter == endFilter) &&
            (identical(other.daysOfRangeDateProduction,
                    daysOfRangeDateProduction) ||
                other.daysOfRangeDateProduction == daysOfRangeDateProduction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, startFilter, endFilter, daysOfRangeDateProduction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OptionsStateCopyWith<_$_OptionsState> get copyWith =>
      __$$_OptionsStateCopyWithImpl<_$_OptionsState>(this, _$identity);
}

abstract class _OptionsState extends OptionsState {
  const factory _OptionsState(
      {required final DateTime startFilter,
      required final DateTime endFilter,
      final int daysOfRangeDateProduction}) = _$_OptionsState;
  const _OptionsState._() : super._();

  @override
  DateTime get startFilter;
  @override
  DateTime get endFilter;
  @override
  int get daysOfRangeDateProduction;
  @override
  @JsonKey(ignore: true)
  _$$_OptionsStateCopyWith<_$_OptionsState> get copyWith =>
      throw _privateConstructorUsedError;
}
