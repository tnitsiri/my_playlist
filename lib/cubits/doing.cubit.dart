import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

// ANCHOR Doing Cubit
class DoingCubit extends Cubit<bool> {
  DoingCubit() : super(false) {
    _init();
  }

  // ANCHOR Init
  void _init() {
    SVProgressHUD.setDefaultStyle(
      SVProgressHUDStyle.dark,
    );
  }

  // ANCHOR Show
  void show({
    String? message,
  }) {
    emit(true);

    SVProgressHUD.show(
      status: message,
    );
  }

  // ANCHOR Hide
  void hide() {
    emit(false);

    SVProgressHUD.dismiss();
  }
}
