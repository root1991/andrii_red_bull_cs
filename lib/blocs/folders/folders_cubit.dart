import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_bull_case_study/data/local_data_source.dart';

class FoldersCubit extends Cubit<List<String>> {
  FoldersCubit() : super(LocalDataSource.folders);

  void searchFolder(String query) {
    var folders = LocalDataSource.folders;
    emit(
      folders.where((folder) {
        final folderLower = folder.toLowerCase();
        final queryLower = query.toLowerCase();
        return folderLower.contains(queryLower);
      }).toList(),
    );
  }
}
