import 'package:equatable/equatable.dart';

class FolderContentState extends Equatable {
  final bool isLoading;
  final bool isPaginating;
  final bool isSearching;
  final String? errorMessage;
  final List<Item> items;

  const FolderContentState({
    this.isLoading = false,
    this.isPaginating = false,
    this.isSearching = false,
    this.errorMessage,
    this.items = const [],
  });

  FolderContentState copyWith({
    bool? isLoading,
    bool? isPaginating,
    bool? isSearching,
    String? errorMessage,
    List<Item>? items,
  }) {
    return FolderContentState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isPaginating: isPaginating ?? this.isPaginating,
      isSearching: isSearching ?? this.isSearching,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, items, isPaginating];

  static FolderContentState loading() =>
      const FolderContentState(isLoading: true, items: []);
}

class Item extends Equatable {
  final int id;
  final String name;
  final String? duration;
  final String creationDate;
  final String thumbnailUrl;
  final bool isPicture;

  const Item({
    required this.id,
    required this.name,
    required this.isPicture,
    this.duration,
    required this.creationDate,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, name, duration, creationDate, thumbnailUrl];
}
