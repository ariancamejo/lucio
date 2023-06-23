// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'units_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UnitsState {
  UnitOfMeasurementModel? get selected => throw _privateConstructorUsedError;
  List<UnitOfMeasurementModel> get units => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UnitsStateCopyWith<UnitsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitsStateCopyWith<$Res> {
  factory $UnitsStateCopyWith(
          UnitsState value, $Res Function(UnitsState) then) =
      _$UnitsStateCopyWithImpl<$Res, UnitsState>;
  @useResult
  $Res call(
      {UnitOfMeasurementModel? selected, List<UnitOfMeasurementModel> units});
}

/// @nodoc
class _$UnitsStateCopyWithImpl<$Res, $Val extends UnitsState>
    implements $UnitsStateCopyWith<$Res> {
  _$UnitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = freezed,
    Object? units = null,
  }) {
    return _then(_value.copyWith(
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as UnitOfMeasurementModel?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitOfMeasurementModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnitsStateCopyWith<$Res>
    implements $UnitsStateCopyWith<$Res> {
  factory _$$_UnitsStateCopyWith(
          _$_UnitsState value, $Res Function(_$_UnitsState) then) =
      __$$_UnitsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UnitOfMeasurementModel? selected, List<UnitOfMeasurementModel> units});
}

/// @nodoc
class __$$_UnitsStateCopyWithImpl<$Res>
    extends _$UnitsStateCopyWithImpl<$Res, _$_UnitsState>
    implements _$$_UnitsStateCopyWith<$Res> {
  __$$_UnitsStateCopyWithImpl(
      _$_UnitsState _value, $Res Function(_$_UnitsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = freezed,
    Object? units = null,
  }) {
    return _then(_$_UnitsState(
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as UnitOfMeasurementModel?,
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitOfMeasurementModel>,
    ));
  }
}

/// @nodoc

class _$_UnitsState extends _UnitsState {
  const _$_UnitsState(
      {this.selected, final List<UnitOfMeasurementModel> units = const []})
      : _units = units,
        super._();

  @override
  final UnitOfMeasurementModel? selected;
  final List<UnitOfMeasurementModel> _units;
  @override
  @JsonKey()
  List<UnitOfMeasurementModel> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  String toString() {
    return 'UnitsState(selected: $selected, units: $units)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnitsState &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            const DeepCollectionEquality().equals(other._units, _units));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selected, const DeepCollectionEquality().hash(_units));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnitsStateCopyWith<_$_UnitsState> get copyWith =>
      __$$_UnitsStateCopyWithImpl<_$_UnitsState>(this, _$identity);
}

abstract class _UnitsState extends UnitsState {
  const factory _UnitsState(
      {final UnitOfMeasurementModel? selected,
      final List<UnitOfMeasurementModel> units}) = _$_UnitsState;
  const _UnitsState._() : super._();

  @override
  UnitOfMeasurementModel? get selected;
  @override
  List<UnitOfMeasurementModel> get units;
  @override
  @JsonKey(ignore: true)
  _$$_UnitsStateCopyWith<_$_UnitsState> get copyWith =>
      throw _privateConstructorUsedError;
}
