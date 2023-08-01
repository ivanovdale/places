import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/features/place_search/presentation/redux/place_search_state.dart';
import 'package:redux/redux.dart';

extension ReduxStoreExt on BuildContext {
  Store<PlaceSearchState> get reduxStore => StoreProvider.of<PlaceSearchState>(this);
}
