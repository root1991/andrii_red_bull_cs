import 'package:flutter_bloc/flutter_bloc.dart';

class RedBullTextFieldCubit extends Cubit<bool> {
  RedBullTextFieldCubit() : super(true);

  void toggle() => emit(!state);
}