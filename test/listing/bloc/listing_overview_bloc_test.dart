import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/list_overview/repository/listing_repository.dart';
import 'package:todo/todo_overview/repository/todo_repository.dart';

class FakeListing extends Fake implements Listing {}

class TodoRepositoryMock extends Mock implements TodoRepository {}

class ListingRepositoryMock extends Mock implements ListingRepository {}

const List<Listing> mockListing = [
  Listing(id: 1, name: "To-do", count: 2),
  Listing(id: 2, name: "Groceries", count: 3),
  Listing(id: 3, name: "Work", count: 5),
  Listing(id: 4, name: "Ideas", count: 7),
];

void main() {
  late ListingRepositoryMock listingRepository;

  group('ListingOverviewBloc', () {
    setUpAll(() {
      registerFallbackValue(FakeListing());
    });

    setUp(() {
      listingRepository = ListingRepositoryMock();
      when(
        () => listingRepository.getListing(),
      ).thenAnswer((_) => Stream.value(mockListing));
      when(() => listingRepository.saveListing(any())).thenAnswer((_) async {});
    });

    ListingOverviewBloc buildBloc() {
      return ListingOverviewBloc(listRepository: listingRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const ListingOverviewLoadedState(list: [])),
        );
      });
    });

    group('ListingOverviewSubscriptionRequested', () {
      blocTest<ListingOverviewBloc, ListingOverviewState>(
        'starts listening to repository getListing stream',
        build: buildBloc,
        act: (bloc) => bloc.add(ListingOverviewListSubscriptionRequested()),
        verify: (_) {
          verify(() => listingRepository.getListing()).called(1);
        },
      );
    });
    blocTest<ListingOverviewBloc, ListingOverviewState>(
      'emits ListingOverviewLoadedState '
      'when repository getListing stream emits new listing',
      build: buildBloc,
      act: (bloc) => bloc.add(ListingOverviewListSubscriptionRequested()),
      expect: () => [
        ListingOverviewLoadingState(list: []),
        ListingOverviewLoadedState(list: mockListing),
      ],
    );

    blocTest<ListingOverviewBloc, ListingOverviewState>(
      'emits state with failure status '
      'when repository getListing stream emits error',
      build: buildBloc,
      setUp: () {
        when(
          () => listingRepository.getListing(),
        ).thenAnswer((_) => Stream.error(Exception('Failed to fetch listing')));
      },
      act: (bloc) => bloc.add(ListingOverviewListSubscriptionRequested()),
      expect: () => [
        ListingOverviewLoadingState(list: []),
        ListingOverviewErrorState(
          list: [],
          error: Exception('Exception: Failed to fetch listing'),
        ),
      ],
    );

    group('ListingOverviewListingAdded', () {
      blocTest<ListingOverviewBloc, ListingOverviewState>(
        "saves  listing",
        build: buildBloc,
        act: (bloc) => bloc.add(
          ListingOverviewListingSaved(
            listing: Listing(id: 5, name: "Project Ideas", count: 11),
          ),
        ),
        seed: () => ListingOverviewLoadedState(list: mockListing),
        verify: (_) {
          verify(
            () => listingRepository.saveListing(
              Listing(id: 5, name: "Project Ideas", count: 11),
            ),
          ).called(1);
        },
      );
    });
    group('ListingOverviewListingDeleted', () {
      blocTest<ListingOverviewBloc, ListingOverviewState>(
        "deletes todo using repository",
        build: buildBloc,
        setUp: () {
          when(() => listingRepository.delete(any())).thenAnswer((_) async {});
        },
        act: (bloc) => bloc.add(ListingOverviewListingDeleted(id: 1)),
        seed: () => ListingOverviewLoadedState(list: mockListing),
        verify: (_) {
          verify(() => listingRepository.delete(1)).called(1);
        },
      );
    });
  });
}
