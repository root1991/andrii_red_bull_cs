import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Result<D, E> {
  const Result();

  /// Returns true if the current result is an [Failure].
  bool get isFailure;

  /// Returns true if the current result is a [data].
  bool get isSuccess;

  /// Returns the value of [D].
  D? get data;

  /// Returns the value of [E].
  E? get error;

  /// Return the result in one of these functions.
  ///
  /// if the result is an error, it will be returned in
  /// [whenError],
  /// if it is a success it will be returned in [whenSuccess].
  W when<W>(
    W Function(D data) whenSuccess,
    W Function(E error) whenError,
  );

  /// Returns a new [Result] type whose [data] is transformed with [f].
  ///
  /// If this [Result] is [Success], returns another [Success] with a [data] of
  /// type [T] computed by processing the original data of type [D] with the
  /// provided [f].
  ///
  /// If this [Result] is [Failure], returns another [Failure] with its error
  /// unchanged.
  Result<T, E> mapSuccess<T>(T Function(D data) f);
}

/// Success Result.
///
/// return it when the result of a [Result] is
/// the expected value.
@immutable
class Success<D, E> extends Equatable implements Result<D, E> {
  /// Receives the [D] param as
  /// the result data.
  const Success(
    this._data,
  );

  final D _data;

  @override
  bool get isFailure => false;

  @override
  bool get isSuccess => true;

  @override
  D get data => _data;

  @override
  E? get error => null;

  @override
  W when<W>(
    W Function(D data) whenSuccess,
    W Function(E error) whenError,
  ) {
    return whenSuccess(_data);
  }

  @override
  List<Object?> get props => [_data];

  @override
  Result<T, E> mapSuccess<T>(T Function(D data) f) => Success(f(data));
}

/// Failure Result.
///
/// return it when the result of a [Result] is
/// not the expected value.
@immutable
class Failure<D, E> extends Equatable implements Result<D, E> {
  /// Receives the [E] param as
  /// the result error.
  const Failure(this._error);

  final E _error;

  @override
  bool get isFailure => true;

  @override
  bool get isSuccess => false;

  @override
  D? get data => null;

  @override
  E get error => _error;

  @override
  W when<W>(
    W Function(D data) whenSuccess,
    W Function(E error) whenError,
  ) {
    return whenError(_error);
  }

  @override
  List<Object?> get props => [_error];

  @override
  Result<T, E> mapSuccess<T>(T Function(D data) f) => Failure(error);
}