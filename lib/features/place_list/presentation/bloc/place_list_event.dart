part of 'place_list_bloc.dart';

sealed class PlaceListEvent {}

final class PlaceListStarted extends PlaceListEvent {}

final class PlaceFiltersSubscriptionRequested extends PlaceListEvent {}

final class PlaceListLoaded extends PlaceListEvent {}

final class _PlaceFiltersUpdated extends PlaceListEvent {}
