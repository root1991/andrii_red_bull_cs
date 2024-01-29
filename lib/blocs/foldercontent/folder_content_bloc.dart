import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_bull_case_study/blocs/foldercontent/folder_content_event.dart';
import 'package:red_bull_case_study/blocs/foldercontent/folder_content_state.dart';
import 'package:red_bull_case_study/data/folder_content_repo.dart';
import 'package:red_bull_case_study/network/app_network_exception.dart';

class FolderContentBloc extends Bloc<FolderContentEvent, FolderContentState> {
  final FolderContentRepo _repo;

  FolderContentBloc(this._repo) : super(FolderContentState.loading()) {
    on<LoadItemsEvent>(_onLoadItemsEvent);
    on<NextPageEvent>(_onNextPageEvent);
    on<SearchEvent>(_onSearchEvent);
  }

  Future<void> _onLoadItemsEvent(
      LoadItemsEvent event, Emitter<FolderContentState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final items = await _repo.loadItemsByFolder(event.folder, true);
      emit(state.copyWith(isLoading: false, items: items));
    } on NetworkConnectionException {
      emit(state.copyWith(errorMessage: 'Network error', isLoading: false));
    }
  }

  Future<void> _onNextPageEvent(
      NextPageEvent event, Emitter<FolderContentState> emit) async {
    emit(state.copyWith(isPaginating: true, errorMessage: null));
    try {
      final items = await _repo.loadItemsByFolder(event.folder, false);
      emit(state.copyWith(isPaginating: false, items: items));
    } on NetworkConnectionException {
      emit(state.copyWith(errorMessage: 'Network error', isPaginating: false));
    }
  }

  Future<void> _onSearchEvent(
      SearchEvent event, Emitter<FolderContentState> emit) async {
    final items = await _repo.loadItemsByFolder(event.folder, true);
    if (event.query.isEmpty) {
      emit(state.copyWith(items: items, isSearching: false));
    }
    emit(
      state.copyWith(
          isSearching: true,
          items: items.where((item) {
            final itemLower = item.name.toLowerCase();
            final queryLower = event.query.toLowerCase();
            return itemLower.contains(queryLower);
          }).toList()),
    );
  }
}
