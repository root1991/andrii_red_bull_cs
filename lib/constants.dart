class RedBullConstants {
  static final passwordValidator =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static const folderName = 'folderName';
}

class RedBullRoutes {
  static const auth = '/';
  static const folders = '/folders';
  static const folderContent = '/folder_content/:folderName';
}
