// Mocks generated by Mockito 5.3.2 from annotations
// in todo/subtask/repository/subtask_repository.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/subtask/model/subtask.dart' as _i4;
import 'package:todo/subtask/repository/subtask_repository.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SubtaskRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubtaskRepository extends _i1.Mock implements _i2.SubtaskRepository {
  @override
  void delete(int? id) => super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<List<_i4.Subtask>> fetch({int? todoId}) => (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [],
          {#todoId: todoId},
        ),
        returnValue: _i3.Future<List<_i4.Subtask>>.value(<_i4.Subtask>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Subtask>>.value(<_i4.Subtask>[]),
      ) as _i3.Future<List<_i4.Subtask>>);
  @override
  void insert(_i4.Subtask? subtask) => super.noSuchMethod(
        Invocation.method(
          #insert,
          [subtask],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void update(_i4.Subtask? subtask) => super.noSuchMethod(
        Invocation.method(
          #update,
          [subtask],
        ),
        returnValueForMissingStub: null,
      );
}