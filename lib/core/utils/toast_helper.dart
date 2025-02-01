import 'package:fluttertoast/fluttertoast.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: ColorTheme.textRegular,
    textColor: ColorTheme.backgroundWhite,
    fontSize: 16.0,
  );
}
