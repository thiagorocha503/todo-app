// Mocks generated by Mockito 5.4.2 from annotations
// in todo/test/todo/ui/todo_over_view_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo/filter/model/filter.dart' as _i5;
import 'package:todo/todo_over_view/model/todo.dart' as _i3;
import 'package:todo/todo_over_view/repository/repository.dart' as _i2;

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

/// A class which mocks [ITodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockITodoRepository extends _i1.Mock implements _i2.ITodoRepository {
  @override
  void insert(_i3.Todo? todo) => super.noSuchMethod(
        Invocation.method(
          #insert,
          [todo],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void delete(List<int>? ids) => super.noSuchMethod(
        Invocation.method(
          #delete,
          [ids],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void update(_i3.Todo? todo) => super.noSuchMethod(
        Invocation.method(
          #update,
          [todo],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<List<_i3.Todo>> fetch({required _i5.Filter? filter}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [],
          {#filter: filter},
        ),
        returnValue: _i4.Future<List<_i3.Todo>>.value(<_i3.Todo>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i3.Todo>>.value(<_i3.Todo>[]),
      ) as _i4.Future<List<_i3.Todo>>);
}
