import 'package:red_bull_case_study/blocs/foldercontent/folder_content_state.dart';

class LocalDataSource {
  final Map<String, int> _pageByFolder = {};
  final Map<String, List<Item>> _itemsByFolder = {};

  void saveCurrentPage(String folder) {
    final currentPage = (_pageByFolder[folder] ?? 1) + 1;
    _pageByFolder[folder] = currentPage;
  }

  void saveCurrentItems(String folder, List<Item> items) {
    if (_itemsByFolder[folder] != null) {
      _itemsByFolder[folder]?.addAll(items);
    } else {
      _itemsByFolder[folder] = items;
    }
  }

  List<Item> itemsByFolder(String folder) {
    return _itemsByFolder[folder] ?? [];
  }

  int pageByFolder(String folder) {
    return _pageByFolder[folder] ?? 1;
  }

  static final List<String> folders = [
    'Animals',
    'Architecture',
    'Buildings',
    'Backgrounds',
    'Textures',
    'Beauty',
    'Fashion',
    'Business',
    'Finance',
    'Computer',
    'Communication',
    'Education',
    'Emotions',
    'Food',
    'Drink',
    'Health',
    'Medical',
    'Industry',
    'Craft',
    'Music',
    'Nature',
    'Landscapes',
    'People',
    'Places',
    'Monuments',
    'Religion',
    'Science',
    'Technology',
    'Sports',
    'Transportation',
    'Traffic',
    'Travel',
    'Vacation',
  ];
}


