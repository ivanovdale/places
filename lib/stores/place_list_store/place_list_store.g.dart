// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_store_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  late final _$placesFutureAtom =
      Atom(name: 'PlaceListStoreBase.placesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get placesFuture {
    _$placesFutureAtom.reportRead();
    return super.placesFuture;
  }

  @override
  set placesFuture(ObservableFuture<List<Place>>? value) {
    _$placesFutureAtom.reportWrite(value, super.placesFuture, () {
      super.placesFuture = value;
    });
  }

  late final _$getFilteredPlacesAsyncAction =
      AsyncAction('PlaceListStoreBase.getFilteredPlaces', context: context);

  @override
  Future<void> getFilteredPlaces() {
    return _$getFilteredPlacesAsyncAction.run(() => super.getFilteredPlaces());
  }

  @override
  String toString() {
    return '''
placesFuture: ${placesFuture}
    ''';
  }
}
