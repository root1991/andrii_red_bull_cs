import 'package:equatable/equatable.dart';

abstract class FolderContentEvent extends Equatable {
  const FolderContentEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends FolderContentEvent {
  final String folder;

  const LoadItemsEvent(this.folder);

  @override
  List<Object> get props => [];
}

class NextPageEvent extends FolderContentEvent {
  final String folder;

  const NextPageEvent(this.folder);

  @override
  List<Object> get props => [];
}

class SearchEvent extends FolderContentEvent {
  final String query;
  final String folder;

  const SearchEvent(this.query, this.folder);

  @override
  List<Object> get props => [query];
}
